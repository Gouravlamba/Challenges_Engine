class ProgressModel {
  final String challengeId;
  int completedDays;
  int currentStreak;
  double savedAmount;
  List<bool> dailyCompleted; // length = durationDays

  ProgressModel({
    required this.challengeId,
    required this.completedDays,
    required this.currentStreak,
    required this.savedAmount,
    required this.dailyCompleted,
  });
}
