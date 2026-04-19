class Pass {
  final String price;
  final String period;
  final String planName;
  final String description;
  final List<String> features;
  final String? expireDate;

  const Pass({
    required this.price,
    required this.period,
    required this.planName,
    required this.description,
    required this.features,
    this.expireDate,
  });
}