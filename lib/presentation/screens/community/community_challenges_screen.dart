import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:challenge_engine_app/core/theme/app_colors.dart';
import 'package:challenge_engine_app/state_management/providers/challenge_provider.dart';
import 'package:challenge_engine_app/presentation/screens/challenges/widgets/challenge_card.dart';

class CommunityChallengesScreen extends StatefulWidget {
  const CommunityChallengesScreen({super.key});

  @override
  State<CommunityChallengesScreen> createState() =>
      _CommunityChallengesScreenState();
}

class _CommunityChallengesScreenState extends State<CommunityChallengesScreen> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChallengeProvider>(context);
    final categories = prov.getCategories();

    final communityCats = categories
        .map((c) {
          final filtered = (c['challenges'] as List)
              .where((ch) => (ch['type'] ?? '')
                  .toString()
                  .toLowerCase()
                  .contains('community'))
              .toList();
          return {...c, 'challenges': filtered};
        })
        .where((c) => (c['challenges'] as List).isNotEmpty)
        .toList();

    final filteredCats = selectedCategory == 'All'
        ? communityCats
        : communityCats
            .where((c) => c['category'] == selectedCategory)
            .toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildFilterBar(communityCats),
            const SizedBox(height: 8),
            ...filteredCats
                .map((cat) => _buildCategorySection(context, cat, prov))
                .toList(),
          ],
        ),
      ),
    );
  }

  // ---------------- CATEGORY FILTER BAR -----------------
  Widget _buildFilterBar(List<Map<String, dynamic>> categories) {
    final names = ['All', ...categories.map((c) => c['category']).toList()];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: names.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final isSelected = selectedCategory == names[i];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = names[i]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGreen : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  names[i],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- CATEGORY SECTIONS -----------------
  Widget _buildCategorySection(
      BuildContext context, Map<String, dynamic> cat, ChallengeProvider prov) {
    final List<dynamic> challenges = cat['challenges'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              cat['icon'] ?? '🤝',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 6),
            Text(
              cat['category'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: challenges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (ctx, i) {
              final ch = challenges[i];
              return ChallengeCard.fromJson(
                ch,
                onJoin: () {
                  prov.joinChallenge(ch['id']);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
