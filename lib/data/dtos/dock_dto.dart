import 'package:final_project/data/dtos/bike_dto.dart';
import 'package:final_project/model/dock.dart';

class DockDto {
  static const String idKey   = 'id';
  static const String bikeKey = 'bike';

  static Dock fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[bikeKey] == null || json[bikeKey] is Map<String, dynamic>);

    return Dock(
      id:   json[idKey],
      bike: json[bikeKey] != null
          ? BikeDto.fromJson(json[bikeKey])
          : null,
    );
  }

  static Map<String, dynamic> toJson(Dock dock) {
    return {
      idKey:   dock.id,
      bikeKey: dock.bike != null ? BikeDto.toJson(dock.bike!) : null,
    };
  }
}