import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:challenge_engine_app/state_management/providers/challenge_provider.dart';
import 'package:challenge_engine_app/presentation/screens/challenges/widgets/progress_bar_widget.dart';

class ProgressOverviewScreen extends StatelessWidget {
  const ProgressOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChallengeProvider>(context);
    final active = prov.myActiveChallenges;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: active.isEmpty
            ? const Center(
                child: Text(
                  'No active challenges yet.\nJoin one to start tracking progress!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: active.length,
                itemBuilder: (ctx, i) {
                  final c = active[i];
                  final p = prov.progressFor(c.id)!;

                  return Card(
                    color: const Color.fromARGB(255, 233, 244, 233),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: Icon(
                        c.isCompleted ? Icons.shield : Icons.flag_rounded,
                        color: c.isCompleted ? Colors.green : Colors.grey,
                      ),
                      title: Text(c.title),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          ProgressBarWidget(progress: p, total: c.durationDays),
                          const SizedBox(height: 6),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < c.rating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${c.completedDays} of ${c.durationDays} days complete — £${c.suggestedSavings.toStringAsFixed(1)} saved',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.emoji_events, color: Colors.amber),
                          Text(c.isCompleted ? 'Done' : 'Active'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
