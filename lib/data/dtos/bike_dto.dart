import 'package:final_project/model/bike.dart';

class BikeDto {
  static const String idKey     = 'id';

  static Bike fromJson(String id, Map<String, dynamic> json) {
    return Bike(
      id: id,
    );
  }

  static Map<String, dynamic> toJson(Bike bike) {
    return {
      idKey:     bike.id,
    };
  }
}