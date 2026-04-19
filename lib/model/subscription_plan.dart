class SubscriptionModel {
  const SubscriptionModel({
    required this.id,
    required this.price,
    required this.currency,
    required this.period,
    required this.planName,
    required this.description,
    required this.features,
    this.expireDate,
  });

  final String id;
  final double price;
  final String currency;
  final String period;
  final String planName;
  final String description;
  final List<String> features;
  final String? expireDate; 

  @override
  String toString() =>
      'SubscriptionModel(id: $id, planName: $planName, price: $price $currency/$period)';
}
