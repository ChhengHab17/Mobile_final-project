import 'package:flutter/material.dart';
import 'package:final_project/ui/theme/theme.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    required this.price,
    required this.period,
    required this.isExpanded,
  });

  final String price;
  final String period;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Price
        Text(
          price,
          style: AppTextStyles.heading.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: AppSpacings.xs),
        // Period
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text(
            period,
            style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
          ),
        ),
        const Spacer(),
        // Chevron
        Icon(
          isExpanded
              ? Icons.keyboard_arrow_up_rounded
              : Icons.keyboard_arrow_down_rounded,
          color: AppColors.textSecondary,
          size: 26,
        ),
      ],
    );
  }
}
