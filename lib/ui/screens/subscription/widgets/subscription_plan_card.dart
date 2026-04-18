import 'package:flutter/material.dart';
import '../../../utils/theme.dart';

enum PlanButtonStyle { primary, accent, cancel }

class SubscriptionPlanCard extends StatelessWidget {
  const SubscriptionPlanCard({
    super.key,
    required this.price,
    required this.period,
    required this.planName,
    required this.description,
    this.features = const [],
    this.expireDate,
    required this.buttonLabel,
    this.buttonStyle = PlanButtonStyle.primary,
    required this.isExpanded,
    required this.onToggle,
    required this.onButtonTap,
  });

  final String price;
  final String period;
  final String planName;
  final String description;
  final List<String> features;
  final String? expireDate;
  final String buttonLabel;
  final PlanButtonStyle buttonStyle;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onButtonTap;

  Border get _cardBorder => Border.all(
    color: isExpanded ? AppColors.primary : AppColors.border,
    width: isExpanded ? 2.0 : 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.cardRadius,
          border: _cardBorder,
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CardHeader(price: price, period: period, isExpanded: isExpanded),
            if (isExpanded)
              _ExpandedBody(
                planName: planName,
                description: description,
                features: features,
                expireDate: expireDate,
                buttonLabel: buttonLabel,
                buttonStyle: buttonStyle,
                onButtonTap: onButtonTap,
              )
            else
              _CollapsedBody(
                planName: planName,
                description: description,
                buttonLabel: buttonLabel,
                buttonStyle: buttonStyle,
                onButtonTap: onButtonTap,
              ),
          ],
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
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
        Text(price, style: AppTextStyles.priceHero),
        const SizedBox(width: AppSpacing.xs),
        // Period
        Padding(
          padding: const EdgeInsets.only(top: 14),
          child: Text(period, style: AppTextStyles.pricePeriod),
        ),
        const Spacer(),
        // Chevron — down when collapsed, up when expanded
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

class _CollapsedBody extends StatelessWidget {
  const _CollapsedBody({
    required this.planName,
    required this.description,
    required this.buttonLabel,
    required this.buttonStyle,
    required this.onButtonTap,
  });

  final String planName;
  final String description;
  final String buttonLabel;
  final PlanButtonStyle buttonStyle;
  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),
        Text(planName, style: AppTextStyles.planTitle),
        const SizedBox(height: AppSpacing.xs),
        Text(description, style: AppTextStyles.subtitle),
        const SizedBox(height: AppSpacing.md),
        _PlanButton(label: buttonLabel, style: buttonStyle, onTap: onButtonTap),
      ],
    );
  }
}

class _ExpandedBody extends StatelessWidget {
  const _ExpandedBody({
    required this.planName,
    required this.description,
    required this.features,
    this.expireDate,
    required this.buttonLabel,
    required this.buttonStyle,
    required this.onButtonTap,
  });

  final String planName;
  final String description;
  final List<String> features;
  final String? expireDate;
  final String buttonLabel;
  final PlanButtonStyle buttonStyle;
  final VoidCallback onButtonTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.xs),

        // Plan name in orange
        Text(planName, style: AppTextStyles.planTitle),
        const SizedBox(height: AppSpacing.sm),

        // Description body
        Text(description, style: AppTextStyles.bodyMedium),
        const SizedBox(height: AppSpacing.md),

        // Feature checklist
        if (features.isNotEmpty) ...[
          ...features.map((f) => _FeatureRow(text: f)),
          const SizedBox(height: AppSpacing.md),
        ],

        // Expire date
        if (expireDate != null) ...[
          RichText(
            text: TextSpan(
              style: AppTextStyles.caption,
              children: [
                const TextSpan(
                  text: 'Expire date: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: expireDate),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // CTA button
        _PlanButton(label: buttonLabel, style: buttonStyle, onTap: onButtonTap),
      ],
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_rounded, color: AppColors.primary, size: 18),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(text, style: AppTextStyles.featureItem)),
        ],
      ),
    );
  }
}

class _PlanButton extends StatelessWidget {
  const _PlanButton({
    required this.label,
    required this.style,
    required this.onTap,
  });

  final String label;
  final PlanButtonStyle style;
  final VoidCallback onTap;

  Color get _bgColor {
    switch (style) {
      case PlanButtonStyle.accent:
        return AppColors.accent;
      case PlanButtonStyle.primary:
      case PlanButtonStyle.cancel:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _bgColor,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.buttonRadius),
          padding: EdgeInsets.zero,
        ),
        child: Text(label, style: AppTextStyles.buttonLabel),
      ),
    );
  }
}
