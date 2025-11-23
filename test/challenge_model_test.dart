import 'package:flutter_test/flutter_test.dart';
import 'package:challenge_engine_app/data/models/challenge_model.dart';

void main() {
  test('ChallengeModel fromJson', () {
    final json = {
      "id": "test",
      "title": "Test",
      "description": "desc",
      "duration_days": 3,
      "suggested_savings": 10,
      "category": "Savings",
      "type": "solo",
      "active": true,
      "badge": "T",
      "streak_points": 5
    };
    final c = ChallengeModel.fromJson(json);
    expect(c.id, 'test');
    expect(c.durationDays, 3);
  });
}
