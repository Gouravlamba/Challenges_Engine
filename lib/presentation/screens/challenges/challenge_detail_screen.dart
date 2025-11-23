import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:challenge_engine_app/core/theme/app_colors.dart';
import 'package:challenge_engine_app/state_management/providers/challenge_provider.dart';
import 'package:challenge_engine_app/data/models/challenge_model.dart';

class ChallengeDetailScreen extends StatefulWidget {
  final ChallengeModel challenge;
  const ChallengeDetailScreen({super.key, required this.challenge});

  @override
  State<ChallengeDetailScreen> createState() => _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends State<ChallengeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChallengeProvider>(context);
    final challenge = widget.challenge;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryGreen,
        title:
            Text(challenge.title, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              challenge.description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: challenge.progress,
                color: AppColors.primaryGreen,
                backgroundColor: Colors.grey[300],
                minHeight: 10,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Progress: ${(challenge.progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // DAILY TASKS LIST
            Expanded(
              child: ListView.builder(
                itemCount: challenge.durationDays,
                itemBuilder: (ctx, i) {
                  final isDone = i < challenge.completedDays;
                  return ListTile(
                    leading: Icon(
                      isDone ? Icons.check_circle : Icons.circle_outlined,
                      color: isDone ? Colors.green : Colors.grey,
                    ),
                    title: Text('Day ${i + 1}'),
                    trailing: !isDone
                        ? ElevatedButton(
                            onPressed: () {
                              prov.completeDay(challenge.id);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryGreen,
                            ),
                            child: const Text('Complete'),
                          )
                        : const Text('Done ✅'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
