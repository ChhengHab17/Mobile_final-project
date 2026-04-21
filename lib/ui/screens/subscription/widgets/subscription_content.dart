import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/subscription_plan.dart';
import '../../../../ui/utils/asyncvalue.dart';
import '../../../../ui/theme/theme.dart';
import '../view_model/subscription_view_model.dart';
import 'subscription_plan_card.dart';

class SubscriptionContent extends StatefulWidget {
  const SubscriptionContent({super.key});

  @override
  State<SubscriptionContent> createState() => _SubscriptionContentState();
}

class _SubscriptionContentState extends State<SubscriptionContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionViewModel>().loadSubscriptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SubscriptionViewModel>();
    final value = vm.subscriptionsValue;

    return Scaffold(
      backgroundColor:
          AppColors.textWhite, // fix: was inheriting grey scaffold bg
      body: SafeArea(
        child: Column(
          children: [
            // fix: centered header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacings.m,
                AppSpacings.l,
                AppSpacings.m,
                AppSpacings.m,
              ),
              child: Column(
                children: [
                  Text(
                    "Subscription Plans",
                    style: AppTextStyles.heading,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacings.xs),
                  Text(
                    "Take advantage of our annual packages starting at \$70/month and ride without limit",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Expanded(
              child: switch (value.state) {
                AsyncValueState.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
                AsyncValueState.error => Center(
                  child: ElevatedButton(
                    onPressed: vm.loadSubscriptions,
                    child: const Text("Retry"),
                  ),
                ),
                AsyncValueState.success => _buildList(vm, value.data!),
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(SubscriptionViewModel vm, List<SubscriptionModel> plans) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacings.m),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        final action = vm.getAction(plan);

        return SubscriptionPlanCard(
          plan: plan,
          buttonLabel: action.label,
          buttonStyle: action.style,
          isExpanded: vm.isExpanded(index),
          onToggle: () => vm.toggleCard(index),
          onButtonTap: () => vm.selectPlan(plan),
        );
      },
    );
  }
}
