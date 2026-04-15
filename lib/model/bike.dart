enum BikeStatus { available, inUse }

class Bike{
  final String id;
  final BikeStatus status;

  Bike({required this.id, required this.status});
}