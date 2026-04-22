import 'package:final_project/data/repositories/bike/bike_repository.dart';
import 'package:final_project/data/repositories/subscription_plan/subscription_plan_repository.dart';
import 'package:final_project/model/bike.dart';
import 'package:final_project/model/dock.dart';
import 'package:final_project/model/station.dart';
import 'package:final_project/model/subscription_plan.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';

class BikeDetailViewModel extends ChangeNotifier {
  final BikeRepository bikeRepository;
  final SubscriptionRepository subscriptionRepository;
  final Station station;
  final Dock dock;

  AsyncValue<Bike> bikeValue = AsyncValue.loading();
  AsyncValue<List<SubscriptionModel>> plansValue = AsyncValue.loading();
  SubscriptionModel? selectedPlan;

  String? get selectedPlanId => selectedPlan?.type;
  Bike get currentBike => bikeValue.data!;

  BikeDetailViewModel({
    required this.bikeRepository,
    required this.subscriptionRepository,
    required this.station,
    required this.dock,
  }) {
    _init();
  }

  Future<void> _init() async {
    await _fetchBikeIfNeeded();
    await _fetchPlans();
  }

  Future<void> _fetchBikeIfNeeded() async {
    if (dock.bikeId == null) {
      bikeValue = AsyncValue.error('No bike in this dock');
      notifyListeners();
      return;
    }
    await fetchBike(dock.bikeId!);
  }

  Future<void> fetchBike(String bikeId) async {
    bikeValue = AsyncValue.loading();
    notifyListeners();

    try {
      final bike = await bikeRepository.getBikeById(bikeId);
      bikeValue = AsyncValue.success(bike);
    } catch (e) {
      bikeValue = AsyncValue.error('Failed to load bike: $e');
    }
    notifyListeners();
  }

  Future<void> _fetchPlans() async {
    plansValue = AsyncValue.loading();
    notifyListeners();

    try {
      final plans = await subscriptionRepository.getSubscriptions();
      plansValue = AsyncValue.success(plans);
    } catch (e) {
      plansValue = AsyncValue.error('Failed to load plans: $e');
    }
    notifyListeners();
  }

  void selectPlan(SubscriptionModel plan) {
    selectedPlan = plan;
    notifyListeners();
  }
}