import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/challenge_model.dart';

class ChallengeRepository {
  // Raw data parsed from JSON
  late Map<String, dynamic> _rawData;

  // All categories with challenges
  List<Map<String, dynamic>> categorizedData = [];

  // Flattened list of all challenges
  List<ChallengeModel> allChallenges = [];

  // -------------------------------------------------------------------------
  // LOAD JSON DATA
  // -------------------------------------------------------------------------
  Future<void> loadMockData() async {
    final String jsonString =
        await rootBundle.loadString('assets/mock/challenges_data.json');
    _rawData = json.decode(jsonString);

    // Extract categories
    categorizedData = List<Map<String, dynamic>>.from(_rawData['categories']);

    // Flatten all challenges for easy access
    allChallenges = [];
    for (var category in categorizedData) {
      final categoryName = category['category'];
      final List<dynamic> challenges = category['challenges'];

      for (var c in challenges) {
        allChallenges.add(
          ChallengeModel(
            id: c['id'],
            title: c['title'],
            description: c['description'],
            durationDays: _parseDuration(c['duration_days']),
            suggestedSavings: (c['suggested_savings'] is num)
                ? (c['suggested_savings'] as num).toDouble()
                : 0.0,
            category: categoryName,
            type: c['type'] ?? 'Solo',
            badge: c['badge'] ?? '',
            icon: c['icon'] ?? '🏁',
            active: c['active'] ?? true,
            isJoined: c['is_joined'] ?? false,
            isCompleted: c['is_completed'] ?? false,
            completedDays: (c['completed_days'] as num?)?.toInt() ?? 0,
            progress: (c['progress'] as num?)?.toDouble() ?? 0.0,
            rating: (c['rating'] as num?)?.toDouble() ?? 0.0,
          ),
        );
      }
    }
  }

  // -------------------------------------------------------------------------
  // HELPERS
  // -------------------------------------------------------------------------
  int _parseDuration(dynamic value) {
    if (value is int) return value;
    if (value is String) {
      // Extract number if string like "7 days" or "Monthly"
      final digits = RegExp(r'\d+').stringMatch(value);
      return digits != null ? int.parse(digits) : 7;
    }
    return 7;
  }

  // -------------------------------------------------------------------------
  // PUBLIC ACCESSORS
  // -------------------------------------------------------------------------
  List<ChallengeModel> getChallengesByCategory(String categoryName) {
    return allChallenges.where((c) => c.category == categoryName).toList();
  }

  ChallengeModel? findById(String id) {
    return allChallenges.firstWhere(
      (c) => c.id == id,
      orElse: () => throw Exception('Challenge not found'),
    );
  }

  Map<String, dynamic> get rawJson => _rawData;
}
