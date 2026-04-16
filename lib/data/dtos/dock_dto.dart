import 'package:final_project/model/dock.dart';

class DockDto {
  static const String idKey   = 'id';
  static const String bikeKey = 'bikeId';

  static Dock fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[bikeKey] == null || json[bikeKey] is String);

    return Dock(
      id:   json[idKey],
      bikeId: json[bikeKey], 
    );
  }

  static Map<String, dynamic> toJson(Dock dock) {
    return {
      idKey:   dock.id,
      bikeKey: dock.bikeId,
    };
  }
}