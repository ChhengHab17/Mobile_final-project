import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

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
    color: isExpanded ? AppColors.primary : AppColors.inactive,
    width: isExpanded ? 2.0 : 1.5,
  );

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
        const SizedBox(height: AppSpacings.xs),
        Text(
          planName,
          style: AppTextStyles.heading.copyWith(
            fontSize: 20,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacings.xs),
        Text(
          description,
          style: AppTextStyles.label.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpacings.m),
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
        const SizedBox(height: AppSpacings.xs),

        // Plan name in orange
        Text(
          planName,
          style: AppTextStyles.heading.copyWith(
            fontSize: 20,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacings.s),

        // Description body
        Text(
          description,
          style: AppTextStyles.body.copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: AppSpacings.m),

        // Feature checklist
        if (features.isNotEmpty) ...[
          ...features.map((f) => _FeatureRow(text: f)),
          const SizedBox(height: AppSpacings.m),
        ],

        // Expire date
        if (expireDate != null) ...[
          RichText(
            text: TextSpan(
              style: AppTextStyles.label.copyWith(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              children: [
                const TextSpan(
                  text: 'Expire date: ',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: expireDate),
              ],
            ),
          ),
          const SizedBox(height: AppSpacings.m),
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
      padding: const EdgeInsets.only(bottom: AppSpacings.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_rounded, color: AppColors.primary, size: 18),
          const SizedBox(width: AppSpacings.s),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.body.copyWith(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
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
        return AppColors.primary;
      case PlanButtonStyle.primary:
        return AppColors.primary;
      case PlanButtonStyle.cancel:
        return AppColors.inactive;
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
          foregroundColor: AppColors.textWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacings.radius),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: AppTextStyles.button.copyWith(color: AppColors.textWhite),
        ),
      ),
    );
  }
}
