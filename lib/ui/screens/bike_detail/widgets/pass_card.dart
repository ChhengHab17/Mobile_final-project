import 'package:flutter/material.dart';
import 'package:final_project/model/pass.dart';
import 'package:final_project/ui/theme/theme.dart';

class PassCard extends StatelessWidget {
  const PassCard({
    super.key,
    required this.pass,
    required this.isSelected,
    required this.onTap,
  });

  final Pass pass;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacings.s),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacings.m),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : AppColors.textWhite,
            borderRadius: BorderRadius.circular(AppSpacings.radius),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.inactive,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pass.planName,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pass.description,
                      maxLines: 1,
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacings.s),
              Text(
                pass.price,
                textAlign: TextAlign.right,
                style: AppTextStyles.heading.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
