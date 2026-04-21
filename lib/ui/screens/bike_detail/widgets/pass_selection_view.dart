import 'package:final_project/model/subscription_plan.dart';
import 'package:final_project/data/repositories/subscription_plan/subscription_plan_repository.dart';
import 'package:final_project/ui/screens/bike_detail/widgets/pass_card.dart';
import 'package:final_project/ui/state/subscription_state.dart';
import 'package:final_project/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassSelectionView extends StatefulWidget {
  const PassSelectionView({super.key, required this.onPassSelected});
  final ValueChanged<SubscriptionModel> onPassSelected;

  @override
  State<PassSelectionView> createState() => _PassSelectionViewState();
}

class _PassSelectionViewState extends State<PassSelectionView> {
  late Future<List<SubscriptionModel>> _plansFuture;

  static const SubscriptionModel _singleTicketPlan = SubscriptionModel(
    type: 'single-ticket',
    price: 2,
    period: 'single',
    planName: 'Single Ticket',
    description: 'Use this bike once',
    features: ['One-time ride'],
  );

  String? _selectedPlanId;

  @override
  void initState() {
    super.initState();
    final SubscriptionRepository subscriptionRepo = context
        .read<SubscriptionRepository>();
    _plansFuture = subscriptionRepo.getSubscriptions();
  }

  void _onSelectPlan(SubscriptionModel plan) {
    setState(() {
      _selectedPlanId = plan.type;
    });
    widget.onPassSelected(plan);
  }

  @override
  Widget build(BuildContext context) {
    final userPassState = context.watch<SubscriptionState>();
    final hasActivePass = userPassState.hasActivePass;

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
                    'You have an active pass: ${userPassState.activePass!.planName}',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (!hasActivePass) ...[
          PassCard(
            plan: _singleTicketPlan,
            isSelected: _selectedPlanId == _singleTicketPlan.type,
            onTap: () => _onSelectPlan(_singleTicketPlan),
          ),
          FutureBuilder<List<SubscriptionModel>>(
            future: _plansFuture,
             builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacings.s),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacings.s),
                   child: Text(
                    'Failed to load plans: ${snapshot.error}',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                );
              }

              final List<SubscriptionModel> plans = snapshot.data ?? [];

              return Column(
                children: plans
                    .map(
                      (plan) => PassCard(
                        plan: plan,
                        isSelected: _selectedPlanId == plan.type,
                        onTap: () => _onSelectPlan(plan),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ],
    );
  }
}
