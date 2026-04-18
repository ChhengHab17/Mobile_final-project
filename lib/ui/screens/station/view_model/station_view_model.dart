import 'package:final_project/data/repositories/station/station_repository.dart';
import 'package:final_project/model/station.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';

class StationViewModel extends ChangeNotifier {
  final StationRepository stationRepository;
  final String stationId;

  AsyncValue<Station> stationValue = AsyncValue.loading();

  Station get currentStation => stationValue.data!;
  int get availableBikes => currentStation.availableBikes;
  int get availableParking =>
      currentStation.docks.where((dock) => dock.bikeId == null).length;
  

  StationViewModel({required this.stationRepository, required this.stationId}) {
    _init();
  }

  Future<void> _init() async {
    await fetchStationById(stationId);
  }

  Future<void> fetchStationById(String stationId) async {
    stationValue = AsyncValue.loading();
    notifyListeners();

    try {
      Station station = await stationRepository.getStationById(stationId);
      stationValue = AsyncValue.success(station);
    } catch (e) {
      stationValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
