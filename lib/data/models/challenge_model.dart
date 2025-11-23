class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final int durationDays;
  final double suggestedSavings;
  final String category;
  final String type;
  final String badge;
  final String icon; // 👈 New field

  bool active;
  bool isJoined;
  bool isCompleted;
  int completedDays;
  double progress;
  double rating;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.suggestedSavings,
    required this.category,
    required this.type,
    required this.badge,
    required this.icon,
    this.active = true,
    this.isJoined = false,
    this.isCompleted = false,
    this.completedDays = 0,
    this.progress = 0.0,
    this.rating = 0.0,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> j) {
    return ChallengeModel(
      id: j['id'],
      title: j['title'],
      description: j['description'],
      durationDays: (j['duration_days'] as num).toInt(),
      suggestedSavings: (j['suggested_savings'] as num).toDouble(),
      category: j['category'],
      type: j['type'],
      badge: j['badge'] ?? '',
      icon: j['icon'] ?? '🏁',
      active: j['active'] ?? true,
      isJoined: j['is_joined'] ?? false,
      isCompleted: j['is_completed'] ?? false,
      completedDays: (j['completed_days'] as num?)?.toInt() ?? 0,
      progress: (j['progress'] as num?)?.toDouble() ?? 0.0,
      rating: (j['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
