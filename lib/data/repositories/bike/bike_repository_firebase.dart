import 'dart:convert';

import 'package:final_project/config/firebase_config.dart';
import 'package:final_project/data/dtos/bike_dto.dart';
import 'package:final_project/data/repositories/bike/bike_repository.dart';
import 'package:final_project/model/bike.dart';
import 'package:http/http.dart' as http;

class BikeRepositoryFirebase implements BikeRepository {
  @override
  Future<Bike> getBikeById(String bikeId) async {
    final Uri bikeUri = FirebaseConfig.baseUri.replace(
      path: '/bikes/$bikeId.json',
    );

    final http.Response response = await http.get(bikeUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> bikeJson = json.decode(response.body);
      return BikeDto.fromJson(bikeId, bikeJson);
    } else {
      throw Exception('Failed to load bike $bikeId: ${response.statusCode}');
    }
  }
}
