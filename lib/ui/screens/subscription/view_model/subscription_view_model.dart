import 'package:flutter/material.dart';
import '../../../../model/subscription_plan.dart';
import '../../../../data/repositories/subscription_plan/subscription_plan_repository.dart';
import '../../../state/subscription_state.dart';
import '../../../utils/asyncvalue.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final SubscriptionRepository repository;
  final SubscriptionState userPassState;

  SubscriptionViewModel({
    required this.repository,
    required this.userPassState,
  });
//state
  AsyncValue<List<SubscriptionModel>> subscriptionsValue = AsyncValue.loading();

  List<SubscriptionModel> get subscriptions => subscriptionsValue.data ?? [];

//ui state
  int? _expandedIndex;

  bool isExpanded(int index) => _expandedIndex == index;

  void toggleCard(int index) {
    _expandedIndex = (_expandedIndex == index) ? null : index;
    notifyListeners();
  }
  bool isActive(SubscriptionModel plan) {
    return userPassState.activePass?.type == plan.type;
  }

//fetch data from firebase
  Future<void> loadSubscriptions() async {
    subscriptionsValue = AsyncValue.loading();
    notifyListeners();

    try {
      final data = await repository.getSubscriptions();
      subscriptionsValue = AsyncValue.success(data);
    } catch (e) {
      subscriptionsValue = AsyncValue.error(e);
    }

    notifyListeners();
  }

//business logic
  SubscriptionAction getAction(SubscriptionModel plan) {
    final active = userPassState.activePass;

    if (active == null) {
      return SubscriptionAction(
        label: "BUY NOW",
        style: PlanButtonStyle.primary,
        isCurrent: false,
      );
    }

    if (active.type == plan.type) {
      return SubscriptionAction(
        label: "CANCEL PLAN",
        style: PlanButtonStyle.accent,
        isCurrent: true,
      );
    }

    return SubscriptionAction(
      label: "SWITCH PLAN",
      style: PlanButtonStyle.primary,
      isCurrent: false,
    );
  }

//action handle
  Future<void> selectPlan(SubscriptionModel plan) async {
    final active = userPassState.activePass;

    // cancel if same plan
    if (active != null && active.type == plan.type) {
      userPassState.cancelPass();
      notifyListeners();
      return;
    }

    // set new plan
    userPassState.setActivePass(plan);
    notifyListeners();
  }
}

class SubscriptionAction {
  final String label;
  final PlanButtonStyle style;
  final bool isCurrent;

  SubscriptionAction({
    required this.label,
    required this.style,
    required this.isCurrent,
  });
}
