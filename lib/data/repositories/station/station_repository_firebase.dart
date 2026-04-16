import 'dart:convert';

import 'package:final_project/config/firebase_config.dart';
import 'package:final_project/data/dtos/station_dto.dart';
import 'package:final_project/data/repositories/station/station_repository.dart';
import 'package:final_project/model/station.dart';
import 'package:http/http.dart' as http;

class StationRepositoryFirebase implements StationRepository {
  final Uri stationsUri = FirebaseConfig.baseUri.replace(path: '/stations.json');

  @override
  Future<List<Station>> getStations() async {

    final http.Response response = await http.get(stationsUri);
    if (response.statusCode == 200) {
      Map<String, dynamic> stationsJson = json.decode(response.body);
      List<Station> stations = [];
      
      for (final stationJson in stationsJson.entries) {
        stations.add(StationDto.fromJson(stationJson.key, stationJson.value));
      }
      return stations;
    }else{
      throw Exception('Failed to load stations: ${response.statusCode}');
    }
  }
  @override
  Future<Station> getStationById(String stationId) async {
    final Uri stationUri = FirebaseConfig.baseUri.replace(path: '/stations/$stationId.json');
    final http.Response response = await http.get(stationUri);
    if (response.statusCode == 200) {
      Map<String, dynamic> stationJson = json.decode(response.body);
      return StationDto.fromJson(stationId, stationJson);
    }else{
      throw Exception('Failed to load station $stationId: ${response.statusCode}');
    }
  }

  
}