import 'package:final_project/data/repositories/station/station_repository.dart';
import 'package:final_project/model/dock.dart';
import 'package:final_project/model/station.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';

class MapViewModel extends ChangeNotifier{
  final StationRepository stationRepository;

  AsyncValue<List<Station>> stationsValue = AsyncValue.loading();
  
  MapViewModel({required this.stationRepository}){
    _init();
  }

  void _init() {
    fetchStations();
  }
  
  Future<void> fetchStations() async {
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

  List<Dock> getValidDocks(Station station, String? bookedBikeId) {
    return station.docks.where((dock) {
      return dock.bikeId != null && dock.bikeId != bookedBikeId;
    }).toList();
  }
  
}