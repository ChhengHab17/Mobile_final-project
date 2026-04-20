import 'package:flutter/material.dart';
import 'package:final_project/ui/theme/theme.dart';
import '../../../../model/subscription_plan.dart';
import 'cardHeader.dart';
import 'collapseBody.dart';
import 'expandedbody.dart';

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isExpanded,
    required this.onToggle,
    required this.onButtonTap,
    required this.buttonLabel,
    this.buttonStyle = PlanButtonStyle.primary,
  });

  final SubscriptionModel plan;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onButtonTap;
  final String buttonLabel;
  final PlanButtonStyle buttonStyle;

  Border get _cardBorder => Border.all(
    color: isExpanded ? AppColors.primary : AppColors.inactive,
    width: isExpanded ? 2.0 : 1.5,
  );

  String get priceText => "\$${plan.price.toStringAsFixed(0)}";
  String get periodText => "/${plan.period}";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacings.m,
          vertical: AppSpacings.xs,
        ),
        decoration: BoxDecoration(
          color: AppColors.textWhite,
          borderRadius: BorderRadius.circular(AppSpacings.radius),
          border: _cardBorder,
        ),
        padding: const EdgeInsets.all(AppSpacings.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(
              price: priceText,
              period: periodText,
              isExpanded: isExpanded,
            ),
            if (isExpanded)
              ExpandedBody(
                plan: plan,
                buttonLabel: buttonLabel,
                onButtonTap: onButtonTap,
              )
            else
              CollapsedBody(
                plan: plan,
                buttonLabel: buttonLabel,
                onButtonTap: onButtonTap,
              ),
          ],
        ),
      ),
    );
  }
}
