import 'package:flutter/material.dart';
import 'ui/screens/subscription/widgets/subscription_plan_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SubscriptionTestScreen(),
    );
  }
}

class SubscriptionTestScreen extends StatefulWidget {
  const SubscriptionTestScreen({super.key});

  @override
  State<SubscriptionTestScreen> createState() => _SubscriptionTestScreenState();
}

class _SubscriptionTestScreenState extends State<SubscriptionTestScreen> {
  int? expandedIndex;

  void toggle(int index) {
    setState(() {
      expandedIndex = expandedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subscription UI Test"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          /// 🔹 Day Plan
          SubscriptionPlanCard(
            price: "\$10",
            period: "/day",
            planName: "Day Pass",
            description: "Ride unlimited for a day",
            features: const ["Unlimited rides", "Valid for 24 hours"],
            expireDate: "N/A",
            buttonLabel: "BUY NOW",
            buttonStyle: PlanButtonStyle.primary,
            isExpanded: expandedIndex == 0,
            onToggle: () => toggle(0),
            onButtonTap: () {
              debugPrint("Day plan selected");
            },
          ),

          /// 🔹 Monthly Plan
          SubscriptionPlanCard(
            price: "\$200",
            period: "/month",
            planName: "Monthly Pass",
            description: "Unlimited rides for a month",
            features: const ["Unlimited rides", "Priority support"],
            expireDate: "31/12/2026",
            buttonLabel: "CURRENT PLAN",
            buttonStyle: PlanButtonStyle.accent,
            isExpanded: expandedIndex == 1,
            onToggle: () => toggle(1),
            onButtonTap: () {
              debugPrint("Monthly plan clicked");
            },
          ),

          /// 🔹 Annual Plan
          SubscriptionPlanCard(
            price: "\$599",
            period: "/year",
            planName: "Annual Pass",
            description: "Best value for long-term use",
            features: const [
              "Unlimited rides",
              "Best savings",
              "Priority support",
            ],
            expireDate: "31/12/2027",
            buttonLabel: "CANCEL PLAN",
            buttonStyle: PlanButtonStyle.cancel,
            isExpanded: expandedIndex == 2,
            onToggle: () => toggle(2),
            onButtonTap: () {
              debugPrint("Cancel plan");
            },
          ),
        ],
      ),
    );
  }
}
