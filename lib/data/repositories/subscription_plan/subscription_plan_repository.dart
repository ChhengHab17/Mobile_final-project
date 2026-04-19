import '../../../model/subscription_plan.dart';


abstract class SubscriptionRepository {
  /// Returns all available subscription plans.
  Future<List<SubscriptionModel>> getSubscriptions();

  /// Returns a single plan by id, or null if not found.
  Future<SubscriptionModel?> getSubscriptionById(String id);
}
