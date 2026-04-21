import '../../model/subscription_plan.dart';

class SubscriptionDto {
  static const String typeKey = 'type';
  static const String priceKey = 'price';
  static const String periodKey = 'period';
  static const String planNameKey = 'planName';
  static const String descriptionKey = 'description';
  static const String featuresKey = 'features';
  static const String expireDateKey = 'expireDate';

  static SubscriptionModel fromJson(String id, Map<String, dynamic> json) {
    assert(json[priceKey] is num);
    assert(json[periodKey] is String);
    assert(json[planNameKey] is String);
    assert(json[descriptionKey] is String);
    assert(json[featuresKey] is List);

    return SubscriptionModel(
      type: id,
      price: (json[priceKey] as num).toDouble(),
      period: json[periodKey],
      planName: json[planNameKey],
      description: json[descriptionKey],
      features: List<String>.from(json[featuresKey]),
      expireDate: json[expireDateKey] as String?,
    );
  }

  static Map<String, dynamic> toJson(SubscriptionModel model) {
    return {
      priceKey: model.price,
      periodKey: model.period,
      planNameKey: model.planName,
      descriptionKey: model.description,
      featuresKey: model.features,
      expireDateKey: model.expireDate,
    };
  }
}
