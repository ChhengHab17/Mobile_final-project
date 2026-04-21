import 'package:flutter/material.dart';
import 'package:final_project/ui/theme/theme.dart';
import 'package:final_project/ui/widgets/button.dart';
import '../../../../model/subscription_plan.dart';
import 'featureRow.dart';
import '../../../state/subscription_state.dart';
import 'package:provider/provider.dart';

class ExpandedBody extends StatelessWidget {
  const ExpandedBody({
    super.key,
    required this.plan,
    required this.buttonLabel,
    required this.onButtonTap,
    required this.buttonStyle,
  });

  final SubscriptionModel plan;
  final String buttonLabel;
  final VoidCallback onButtonTap;
  final PlanButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SubscriptionState>();

    String formatDate(DateTime date) {
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      final year = date.year.toString().substring(2);
      return "$day/$month/$year";
    }

    Color getButtonColor(PlanButtonStyle style) {
      switch (style) {
        case PlanButtonStyle.primary:
          return AppColors.primary;
        case PlanButtonStyle.accent:
          return AppColors.inactivePlanButton;
        case PlanButtonStyle.cancel:
          return Colors.red;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacings.xs),

        Text(
          plan.planName,
          style: AppTextStyles.heading.copyWith(
            fontSize: 20,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: AppSpacings.s),

        Text(
          plan.description,
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        ),

        const SizedBox(height: AppSpacings.m),

        ...plan.features.map((f) => FeatureRow(text: f)),

        const SizedBox(height: AppSpacings.m),

        if (state.expireDate != null && state.activePass?.type == plan.type) ...[
          Text(
            "Expire date: ${formatDate(state.expireDate!)}",
            style: AppTextStyles.label.copyWith(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacings.m),
        ],

        Button(
          text: buttonLabel,
          onPressed: onButtonTap,
          color: getButtonColor(buttonStyle),
          isActive: true,
          width: double.infinity,
          height: 42,
        ),
      ],
    );
  }
}
