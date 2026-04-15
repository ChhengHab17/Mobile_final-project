import 'package:final_project/data/dtos/dock_dto.dart';
import 'package:final_project/model/station.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String locationKey = 'location';
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';
  static const String docksKey = 'docks';

  static Station fromJson(String id, Map<String, dynamic> json) {
    assert(json[nameKey]      is String);
    assert(json[locationKey]  is String);
    assert(json[latitudeKey]  is double);
    assert(json[longitudeKey] is double);
    assert(json[docksKey]     is List);

    return Station(
      id:        id,
      name:      json[nameKey],
      location:  json[locationKey],
      latitude:  json[latitudeKey],
      longitude: json[longitudeKey],
      docks: (json[docksKey] as List)
          .map((d) => DockDto.fromJson(d))
          .toList(),
    );
  }
}