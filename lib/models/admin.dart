import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String role = 'admin';
  String id;
  String email;
  String name;
  DateTime createdAt;


  Admin({
    required this.id,
    required this.email,
    required this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Admin.fromMap(Map<String, dynamic> map, String docId) {
    return Admin(
      id: docId,
      name: map['name'],
      email: map['email'],
    );
  }

  Future<void> addJurorToCompetition(String jurorId, String competitionId) async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('competitions').doc(competitionId).update({
      'jurors': FieldValue.arrayUnion([jurorId])
    });
  }

  Future<void> addCompetitorToCompetition(String competitorId, String competitionId) async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('competitions').doc(competitionId).update({
      'competitors': FieldValue.arrayUnion([competitorId])
    });
  }
}
