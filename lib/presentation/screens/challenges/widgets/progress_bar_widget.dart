import 'package:challenge_engine_app/core/theme/app_colors.dart';
import 'package:challenge_engine_app/data/models/progress_model.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  final ProgressModel progress;
  final int total;
  const ProgressBarWidget(
      {required this.progress, required this.total, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0.0 : (progress.completedDays / total);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
            value: percent,
            minHeight: 8,
            backgroundColor: AppColors.lightMint,
            color: AppColors.primaryGreen),
        SizedBox(height: 6),
        Text(
            '${progress.completedDays} of $total days complete — you\'ve saved £${progress.savedAmount.toStringAsFixed(1)} so far'),
      ],
    );
  }
}
