import 'package:flutter/foundation.dart';
import '../../data/models/challenge_model.dart';
import '../../data/models/progress_model.dart';
import '../../data/repositories/challenge_repository.dart';

class ChallengeProvider extends ChangeNotifier {
  final ChallengeRepository repository;

  List<ChallengeModel> allChallenges = [];

  List<Map<String, dynamic>> categorizedChallenges = [];

  Map<String, ProgressModel> progressMap = {};

  String categoryFilter = 'All';
  int? durationFilter;

  List<ChallengeModel> myChallenges = [];

  ChallengeProvider(this.repository) {
    _initData();
  }

  void _initData() {
    categorizedChallenges = repository.categorizedData;
    allChallenges = repository.allChallenges;

    for (var c in allChallenges) {
      progressMap[c.id] = ProgressModel(
        challengeId: c.id,
        completedDays: 0,
        currentStreak: 0,
        savedAmount: 0.0,
        dailyCompleted: List.filled(c.durationDays, false),
      );
    }
  }

  List<ChallengeModel> get filteredChallenges {
    var list = allChallenges.where((c) => true).toList();

    if (categoryFilter != 'All') {
      list = list.where((c) => c.category == categoryFilter).toList();
    }

    if (durationFilter != null) {
      list = list.where((c) => c.durationDays == durationFilter).toList();
    }

    return list;
  }

  void setCategoryFilter(String category) {
    categoryFilter = category;
    notifyListeners();
  }

  void setDurationFilter(int? days) {
    durationFilter = days;
    notifyListeners();
  }

  void joinChallenge(String id) {
    final challenge = allChallenges.firstWhere((c) => c.id == id);
    if (!challenge.isJoined) {
      challenge.isJoined = true;
      myChallenges.add(challenge);
    }
    notifyListeners();
  }

  void logDay(String challengeId, int dayIndex, bool completed,
      [double saved = 0]) {
    final p = progressMap[challengeId];
    if (p == null) return;
    if (dayIndex < 0 || dayIndex >= p.dailyCompleted.length) return;

    if (!p.dailyCompleted[dayIndex] && completed) {
      p.dailyCompleted[dayIndex] = true;
      p.completedDays += 1;
      p.currentStreak += 1;
      p.savedAmount += saved;
    } else if (p.dailyCompleted[dayIndex] && !completed) {
      p.dailyCompleted[dayIndex] = false;
      p.completedDays = (p.completedDays - 1).clamp(0, p.dailyCompleted.length);
      p.currentStreak = (p.currentStreak - 1).clamp(0, p.dailyCompleted.length);
      p.savedAmount = (p.savedAmount - saved).clamp(0, double.infinity);
    }
    notifyListeners();
  }

  void completeDay(String id) {
    final c = allChallenges.firstWhere((ch) => ch.id == id);
    if (c.completedDays < c.durationDays) {
      c.completedDays++;
      c.progress = c.completedDays / c.durationDays;
      if (c.completedDays == c.durationDays) {
        c.isCompleted = true;
        c.rating = 5.0;
      } else if (c.progress >= 0.75) {
        c.rating = 4.0;
      } else if (c.progress >= 0.5) {
        c.rating = 3.0;
      } else {
        c.rating = 2.0;
      }
    }
    notifyListeners();
  }

  ProgressModel? progressFor(String challengeId) => progressMap[challengeId];

  List<Map<String, dynamic>> getCategories() => categorizedChallenges;

  List<ChallengeModel> get myActiveChallenges => myChallenges;
}
