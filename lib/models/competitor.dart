import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jura/models/feedback.dart';

class Competitor {
  String id;
  String name;
  String character;
  final String role = 'competitor';
  List<String> feedbacks;

  Competitor({
    required this.id,
    required this.name,
    required this.character,
    this.feedbacks = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'feedbacks': feedbacks,
    };
  }

  factory Competitor.fromMap(Map<String, dynamic> map, String docId) {
    return Competitor(
      id: docId,
      name: map['name'],
      character: map['character'],
      feedbacks: (List<String>.from(map['feedbacks'] ?? [])),
    );
  }

  Future<List<Feedback>> getFeedbacksByIds(List<String> feedbackIds) async {
    if (feedbackIds.isEmpty) return [];

    final db = FirebaseFirestore.instance;
    List<Feedback> feedbackList = [];

    const batchSize = 10;
    for (var i = 0; i < feedbackIds.length; i += batchSize) {
      final batchIds = feedbackIds.sublist(
        i,
        i + batchSize > feedbackIds.length ? feedbackIds.length : i + batchSize,
      );

      final querySnapshot = await db
          .collection('feedbacks')
          .where(FieldPath.documentId, whereIn: batchIds)
          .get();

      feedbackList.addAll(
        querySnapshot.docs.map((doc) => Feedback.fromMap(doc.data(), doc.id))
      );
    }

    return feedbackList;
  }

  Future<int> calculateAverageScore(String idCompetition) async {
    List<Feedback> feedbackList = await getFeedbacksByIds(feedbacks);
    feedbackList = feedbackList.where((f) => f.competitionId == idCompetition).toList();

    if (feedbackList.isEmpty) return 0;

    int totalScore = feedbackList.fold(0, (sum, f) => sum + f.score);
    return (totalScore / feedbackList.length).round();
  }
}
