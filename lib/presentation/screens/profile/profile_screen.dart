import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:challenge_engine_app/state_management/providers/challenge_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key}); // 👈 added const constructor

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChallengeProvider>(context);
    final totalBadges = prov.allChallenges
        .where((c) => prov.progressFor(c.id)!.completedDays == c.durationDays)
        .length;
    final totalSaved = prov.allChallenges.fold<double>(
      0.0,
      (prev, c) => prev + (prov.progressFor(c.id)?.savedAmount ?? 0.0),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/image2.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          const SizedBox(height: 12),
          Text('Gourav', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [Text('$totalBadges'), const Text('Badges')]),
              Column(children: [
                Text('${totalSaved.toStringAsFixed(1)}'),
                const Text('Saved (£)'),
              ]),
              Column(children: [
                Text('${prov.allChallenges.length}'),
                const Text('Challenges'),
              ]),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(child: _badgesList(prov)),
        ],
      ),
    );
  }

  Widget _badgesList(ChallengeProvider prov) {
    return ListView(
      children: prov.allChallenges.map<Widget>((c) {
        final p = prov.progressFor(c.id)!;
        final earned = p.completedDays == c.durationDays;
        return ListTile(
          leading: Icon(
            Icons.emoji_events,
            color: earned ? Colors.amber : Colors.grey,
          ),
          title: Text(c.badge),
          subtitle: Text(c.title),
          trailing: Text(earned ? 'Earned' : 'Locked'),
        );
      }).toList(),
    );
  }
}
