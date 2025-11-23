import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:challenge_engine_app/state_management/providers/challenge_provider.dart';
import 'package:challenge_engine_app/presentation/screens/challenges/widgets/challenge_card.dart';
import 'package:challenge_engine_app/core/theme/app_colors.dart';

class AllChallengesScreen extends StatefulWidget {
  const AllChallengesScreen({super.key});

  @override
  State<AllChallengesScreen> createState() => _AllChallengesScreenState();
}

class _AllChallengesScreenState extends State<AllChallengesScreen> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChallengeProvider>(context);
    final categories = prov.getCategories();

    final filteredCats = selectedCategory == 'All'
        ? categories
        : categories.where((c) => c['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            _buildFilterBar(prov),
            if (prov.myChallenges.isNotEmpty) _buildMyChallenges(prov),
            const SizedBox(height: 10),
            ...filteredCats
                .map((cat) => _buildCategorySection(context, cat, prov))
                .toList(),
          ],
        ),
      ),
    );
  }

  // ---------------- FILTER BAR -----------------
  Widget _buildFilterBar(ChallengeProvider prov) {
    final categories = [
      'All',
      ...prov.getCategories().map((c) => c['category'])
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (ctx, i) {
          final isSelected = selectedCategory == categories[i];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[i]),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGreen : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  categories[i],
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

  // ---------------- MY CHALLENGES -----------------
  Widget _buildMyChallenges(ChallengeProvider prov) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          'My Challenges',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: prov.myChallenges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (ctx, i) => ChallengeCard(
              challenge: prov.myChallenges[i],
              isMyChallenge: true,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- CATEGORY SECTIONS -----------------
  Widget _buildCategorySection(
      BuildContext context, Map<String, dynamic> cat, ChallengeProvider prov) {
    final List<dynamic> challenges = cat['challenges'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          cat['category'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: challenges.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (ctx, i) {
              final challenge = challenges[i];
              return ChallengeCard.fromJson(challenge, onJoin: () {
                prov.joinChallenge(challenge['id']);
              });
            },
          ),
        ),
      ],
    );
  }
}
