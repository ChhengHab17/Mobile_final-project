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
    assert(json[docksKey]     is Map);

    final docks = Map<String, dynamic>.from(json[docksKey]);

    return Station(
      id:        id,
      name:      json[nameKey],
      location:  json[locationKey],
      latitude:  json[latitudeKey],
      longitude: json[longitudeKey],
      docks: docks.entries.map((entry) =>
        DockDto.fromJson(entry.key, Map<String, dynamic>.from(entry.value))
      ).toList(),
    );
  }
  static Map<String, dynamic> toJson(Station station) {
    return {
      nameKey:      station.name,
      locationKey:  station.location,
      latitudeKey:  station.latitude,
      longitudeKey: station.longitude,
      docksKey: {
        for (final dock in station.docks) dock.id: DockDto.toJson(dock)
      },
    };
  }
}