enum PlanButtonStyle { primary, accent, cancel }

class SubscriptionModel {
  const SubscriptionModel({
    required this.type,
    required this.price,
    required this.period,
    required this.planName,
    required this.description,
    required this.features,
    this.expireDate,
  });

  final String type;
  final double price;
  final String period;
  final String planName;
  final String description;
  final List<String> features;
  final String? expireDate;

  @override
  String toString() =>
      'SubscriptionModel(id: $type, planName: $planName, price: $price \$/$period)';
}
