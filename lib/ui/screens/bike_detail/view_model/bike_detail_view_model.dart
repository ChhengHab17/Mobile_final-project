import 'package:final_project/data/repositories/bike/bike_repository.dart';
import 'package:final_project/model/bike.dart';
import 'package:final_project/model/dock.dart';
import 'package:final_project/model/station.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';

class BikeDetailViewModel extends ChangeNotifier {
  final BikeRepository bikeRepository;
  final Station station;
  final Dock dock;

  AsyncValue<Bike> bikeValue = AsyncValue.loading();
  String? selectedPlanId;

  Bike get currentBike => bikeValue.data!;
  
  BikeDetailViewModel({
    required this.bikeRepository,
    required this.station,
    required this.dock,
  }) {
    _init();
  }

  Future<void> _init() async {
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

  void selectPlan(String planId) {
    selectedPlanId = planId;
    notifyListeners();
  }
}