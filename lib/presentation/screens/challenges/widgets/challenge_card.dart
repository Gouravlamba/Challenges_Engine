import 'package:challenge_engine_app/presentation/screens/challenges/challenge_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:challenge_engine_app/core/theme/app_colors.dart';
import 'package:challenge_engine_app/data/models/challenge_model.dart';

class ChallengeCard extends StatelessWidget {
  final ChallengeModel? challenge;
  final Map<String, dynamic>? json;
  final bool isMyChallenge;
  final VoidCallback? onJoin;

  const ChallengeCard({
    super.key,
    this.challenge,
    this.json,
    this.isMyChallenge = false,
    this.onJoin,
  });

  factory ChallengeCard.fromJson(Map<String, dynamic> json,
      {VoidCallback? onJoin}) {
    return ChallengeCard(json: json, onJoin: onJoin);
  }

  @override
  Widget build(BuildContext context) {
    final title = challenge?.title ?? json?['title'];
    final description = challenge?.description ?? json?['description'];
    final icon = json?['icon'] ?? challenge?.icon ?? '💡';
    final isCompleted = challenge?.isCompleted ?? json?['isCompleted'] == true;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChallengeDetailScreen(
              challenge: challenge ?? ChallengeModel.fromJson(json!),
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: 180,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightMint,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(icon, style: const TextStyle(fontSize: 28)),
                const SizedBox(height: 8),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
                const Spacer(),
                if (isMyChallenge)
                  Column(
                    children: [
                      LinearProgressIndicator(
                        value: 0.6,
                        color: AppColors.primaryGreen,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (i) => const Icon(Icons.star,
                              color: Colors.amber, size: 16),
                        ),
                      ),
                    ],
                  )
                else
                  ElevatedButton(
                    onPressed: onJoin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      minimumSize: const Size(double.infinity, 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Join',
                        style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          ),
          if (isCompleted)
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(Icons.shield, color: Colors.green, size: 22),
            ),
        ],
      ),
    );
  }
}
