import 'package:final_project/model/bike.dart';

abstract class BikeRepository {
  Future<Bike> getBikeById(String bikeId);
}