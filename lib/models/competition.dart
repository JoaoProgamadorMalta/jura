import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jura/models/competitor.dart';

class Competition {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> jurors;
  final List<String> competitors;
  final DateTime createdAt;
  final bool isFinished;

  Competition({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.jurors,
    required this.competitors,
    required this.createdAt,
    this.isFinished = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'jurors': jurors,
      'competitors': competitors,
      'createdAt': createdAt.toIso8601String(),
      'isFinished': isFinished,
    };
  }

  factory Competition.fromMap(Map<String, dynamic> map, String docId) {
    return Competition(
      id: docId,
      name: map['name'],
      description: map['description'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      jurors: List<String>.from(map['jurors'] ?? []),
      competitors: List<String>.from(map['competitors'] ?? []),
      createdAt: DateTime.parse(map['createdAt']),
      isFinished: map['isFinished'] ?? false,
    );
  }

  Future<List<Competitor>> getCompetitorsByIds() async {
    final db = FirebaseFirestore.instance;
    List<Competitor> competitorList = [];

    const batchSize = 10;
    for (var i = 0; i < competitors.length; i += batchSize) {
      final batchIds = competitors.sublist(
        i,
        i + batchSize > competitors.length ? competitors.length : i + batchSize,
      );

      final querySnapshot = await db
          .collection('competitors')
          .where(FieldPath.documentId, whereIn: batchIds)
          .get();

      competitorList.addAll(
        querySnapshot.docs.map((doc) => Competitor.fromMap(doc.data(), doc.id))
      );
    }

    return competitorList;
  }
}
