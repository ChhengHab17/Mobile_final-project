import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/subscription_plan/subscription_plan_repository.dart';
import '../../../ui/state/subscription_state.dart';
import 'view_model/subscription_view_model.dart';
import 'widgets/subscription_content.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubscriptionViewModel(
        repository: context.read<SubscriptionRepository>(),
        userPassState: context.read<SubscriptionState>(),
      )..loadSubscriptions(),

      child: const SubscriptionContent(),
    );
  }
}
