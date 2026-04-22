import 'package:final_project/model/subscription_plan.dart';
import 'package:final_project/ui/screens/bike_detail/view_model/bike_detail_view_model.dart';
import 'package:final_project/ui/screens/bike_detail/widgets/pass_card.dart';
import 'package:final_project/ui/state/subscription_state.dart';
import 'package:final_project/ui/theme/theme.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassSelectionView extends StatelessWidget {
  const PassSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BikeDetailViewModel>();
    final subscriptionState = context.watch<SubscriptionState>();
    final bool hasActivePass = subscriptionState.hasActivePass;
    final singlePlan = SubscriptionModel(
      type: 'single-ticket',
      price: 2,
      period: 'single',
      planName: 'Single Ticket',
      description: 'Use this bike once',
      features: ['One-time ride'],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hasActivePass ? 'Pass Applied' : 'Choose Pass',
          style: AppTextStyles.body.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacings.s),

        // Active pass banner
        if (hasActivePass)
          Container(
            padding: const EdgeInsets.all(AppSpacings.m),
            margin: const EdgeInsets.only(bottom: AppSpacings.m),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSpacings.radius),
              border: Border.all(color: AppColors.primary),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.primary),
                const SizedBox(width: AppSpacings.s),
                Expanded(
                  child: Text(
                    'Active pass: ${subscriptionState.activePass!.planName}',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Plan cards when user has no active pass 
        if (!hasActivePass) ...[
          PassCard(
            plan: singlePlan,
            isSelected: vm.selectedPlanId == singlePlan.type,
            onTap: () => vm.selectPlan(singlePlan),
          ),
          const SizedBox(height: AppSpacings.s),

          switch (vm.plansValue.state) {
            AsyncValueState.loading => const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacings.s),
              child: Center(child: CircularProgressIndicator()),
            ),

            AsyncValueState.error => Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacings.s),
              child: Text(
                'Failed to load plans: ${vm.plansValue.error}',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            AsyncValueState.success => Column(
              children: vm.plansValue.data!
                  .map(
                    (SubscriptionModel plan) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacings.s),
                      child: PassCard(
                        plan: plan,
                        isSelected: vm.selectedPlanId == plan.type,
                        onTap: () => vm.selectPlan(plan),
                      ),
                    ),
                  )
                  .toList(),
            ),
          },
        ],
      ],
    );
  }
}
