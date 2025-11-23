import 'package:challenge_engine_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final List<String> categories;
  final List<int> durations;
  final void Function(String) onCategorySelected;
  final void Function(int?) onDurationSelected;

  const FilterSection({
    required this.categories,
    required this.durations,
    required this.onCategorySelected,
    required this.onDurationSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((c) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ActionChip(
                  label: Text(c),
                  onPressed: () => onCategorySelected(c),
                  backgroundColor: AppColors.lightMint,
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 8),
        // Duration filters
        Row(
          children: [
            Text('Duration:'),
            SizedBox(width: 8),
            Wrap(
              spacing: 8,
              children: [
                ActionChip(
                    label: Text('All'),
                    onPressed: () => onDurationSelected(null)),
                ...durations.map((d) => ActionChip(
                    label: Text('${d}d'),
                    onPressed: () => onDurationSelected(d))),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
