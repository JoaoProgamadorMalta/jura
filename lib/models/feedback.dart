class Feedback {
  final String id;
  final String competitorId;
  final String competitionId;
  final String jurorId;
  final int score;  
  final String comment;

  Feedback({
    required this.id,
    required this.competitorId,
    required this.competitionId,
    required this.jurorId,
    required this.score,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'competitorId': competitorId,
      'competitionId': competitionId,
      'jurorId': jurorId,
      'score': score,
      'comment': comment,
    };
  }

  factory Feedback.fromMap(Map<String, dynamic> map, String docId) {
    return Feedback(
      id: docId,
      competitorId: map['competitorId'],
      competitionId: map['competitionId'],
      jurorId: map['jurorId'],
      score: map['score'],
      comment: map['comment'],
    );
  }
}
