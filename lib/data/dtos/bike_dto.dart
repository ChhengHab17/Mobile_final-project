import 'package:final_project/model/bike.dart';

class BikeDto {
  static const String idKey     = 'id';
  static const String statusKey = 'status';

  static Bike fromJson(Map<String, dynamic> json) {
    assert(json[idKey]     is String);
    assert(json[statusKey] is String);

    return Bike(
      id:     json[idKey],     
      status: BikeStatus.values.byName(json[statusKey]),
    );
  }

  static Map<String, dynamic> toJson(Bike bike) {
    return {
      idKey:     bike.id,
      statusKey: bike.status.name,
    };
  }
}