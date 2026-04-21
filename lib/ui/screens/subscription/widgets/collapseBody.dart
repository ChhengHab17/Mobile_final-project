import 'package:flutter/material.dart';
import 'package:final_project/ui/theme/theme.dart';
import 'package:final_project/ui/widgets/button.dart';
import '../../../../model/subscription_plan.dart';

class CollapsedBody extends StatelessWidget {
  const CollapsedBody({
    required this.plan,
    required this.buttonLabel,
    required this.onButtonTap,
    required this.buttonStyle
  });

  final SubscriptionModel plan;
  final String buttonLabel;
  final VoidCallback onButtonTap;
  final PlanButtonStyle buttonStyle;

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: AppSpacings.xs),
        Text(
          plan.description,
          style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacings.m),
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
