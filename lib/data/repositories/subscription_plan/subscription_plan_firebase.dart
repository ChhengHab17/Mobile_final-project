import 'dart:convert';

import 'package:final_project/config/firebase_config.dart';
import '../../dtos/subscription_plan_dto.dart';
import 'subscription_plan_repository.dart';
import '../../../model/subscription_plan.dart';
import 'package:http/http.dart' as http;

class SubscriptionRepositoryFirebase implements SubscriptionRepository {
  final Uri subscriptionsUri = FirebaseConfig.baseUri.replace(
    path: '/subscriptions.json',
  );

  @override
  Future<List<SubscriptionModel>> getSubscriptions() async {
    final http.Response response = await http.get(subscriptionsUri);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      // Handle both List and Map from Firebase
      if (decoded is List) {
        return decoded
            .asMap()
            .entries
            .where((e) => e.value != null)
            .map(
              (e) => SubscriptionDto.fromJson(
                e.key.toString(),
                Map<String, dynamic>.from(e.value),
              ),
            )
            .toList();
      } else {
        final Map<String, dynamic> subscriptionsJson = decoded;
        return subscriptionsJson.entries
            .map(
              (e) => SubscriptionDto.fromJson(
                e.key,
                Map<String, dynamic>.from(e.value),
              ),
            )
            .toList();
      }
    } else {
      throw Exception('Failed to load subscriptions: ${response.statusCode}');
    }
  }

  @override
  Future<SubscriptionModel?> getSubscriptionById(String id) async {
    final Uri subscriptionUri = FirebaseConfig.baseUri.replace(
      path: '/subscriptions/$id.json',
    );

    final http.Response response = await http.get(subscriptionUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> subscriptionJson = json.decode(response.body);
      return SubscriptionDto.fromJson(id, subscriptionJson);
    } else {
      throw Exception(
        'Failed to load subscription $id: ${response.statusCode}',
      );
    }
  }
}
