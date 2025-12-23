import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jura/controllers/provider/user.provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> loginUser ({required String email, required String password, required BuildContext context}) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      String uid = result.user?.uid ?? '';
      Map<String, dynamic> userData = await _db.collection('users').doc(uid).get().then((doc) => doc.data() as Map<String, dynamic>);
      String role = userData['role'] ?? '';
      String name = userData['name'] ?? '';
      final createdAt = (userData['createdAt'] as Timestamp?)?.toDate();

      final credentials = Provider.of<UserProvider>(context, listen: false);
      credentials.setEmail(email);
      credentials.setRole(role);
      credentials.setName(name);
      credentials.setCreatedAt(createdAt);
      return result.user;
    } catch(e){
      print(e);
      return null;
    }
  }

  Future<User?> registerUser({
  required String email,
  required String role,
  required String password,
  required String confirmPassword,
  required String name,
  required BuildContext context,
}) async {
  try {
    if (password != confirmPassword) {
      throw Exception("Passwords do not match");
    }

    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = result.user;

    if (user == null) {
      throw Exception("Failed to create user");
    }

    final userData = {
      'id': user.uid,
      'email': email,
      'name': name,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    };

    final batch = _db.batch();
    batch.set(_db.collection('users').doc(user.uid), userData);
    if (role == 'juror') {
      batch.set(_db.collection('jurors').doc(user.uid), {...userData, 'competitions': []});
    } else if (role == 'competitor') {
      batch.set(_db.collection('competitors').doc(user.uid), userData);
    } else if (role == 'admin') {
      batch.set(_db.collection('admins').doc(user.uid), userData);
    }
    await batch.commit();

    final userDoc = await _db.collection('users').doc(user.uid).get();
    final serverCreatedAt = (userDoc.data()?['createdAt'] as Timestamp?)?.toDate();

    final credentials = Provider.of<UserProvider>(context, listen: false);
    credentials.setEmail(email);
    credentials.setRole(role);
    credentials.setName(name);
    credentials.setCreatedAt(serverCreatedAt);

    return user;
  } catch (e) {
    // rollback: se criou no Auth mas falhou no Firestore
    if (_auth.currentUser != null) {
      await _auth.currentUser!.delete();
    }
    print("Erro no registro: $e");
    return null;
  }
}


  Future<void> logout() async {
    await _auth.signOut();
  }
}