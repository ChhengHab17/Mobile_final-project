import 'package:final_project/model/station.dart';

abstract class StationRepository {
  Future<List<Station>> getStations();
  Future<Station> getStationById(String stationId);
}