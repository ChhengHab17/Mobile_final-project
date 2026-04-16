import 'package:final_project/data/repositories/station/station_repository.dart';
import 'package:final_project/model/station.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';

class MapViewModel extends ChangeNotifier{
  final StationRepository stationRepository;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();
  AsyncValue<Station> stationValue = AsyncValue.loading();
  MapViewModel({required this.stationRepository}){
    _init();
  }

  void _init() async {
    fetchStations();
  }
  
  void fetchStations() async {
    stationsValue = AsyncValue.loading();
    notifyListeners();

    try {
      List<Station> stations = await stationRepository.getStations();
      stationsValue = AsyncValue.success(stations);
    } catch (e) {
      stationsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }
  void fetchStationById(String stationId) async {
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