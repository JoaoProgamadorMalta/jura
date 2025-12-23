import 'package:cloud_firestore/cloud_firestore.dart';

class Juror {
  String id;
  String email;
  String name;
  List<String> competitions;
  final String role = 'juror';
  DateTime createdAt;

  Juror({
    required this.id,
    required this.email,
    required this.name,
    this.competitions = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'competitions': competitions,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Juror.fromMap(Map<String, dynamic> map, String docId) {
    return Juror(
      id: docId,
      email: map['email'],
      name: map['name'],
      competitions: List<String>.from(map['competitions'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Future<void> addFeedbackToCompetitor(String competitorId, int points, String comment) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference feedbackRef = await db.collection('feedbacks').add({
      'jurorId': id,
      'competitorId': competitorId,
      'score': points,
      'comment': comment,
      'createdAt': FieldValue.serverTimestamp()
    });

    await db.collection('competitors').doc(competitorId).update({
      'feedbacks': FieldValue.arrayUnion([feedbackRef.id])
    });
  }
}
