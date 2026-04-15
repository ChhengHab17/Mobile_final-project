  import 'package:final_project/model/dock.dart';

  class Station {
    final String id;
    final String name;
    final List<Dock> docks;
    final String location;
    final double latitude;
    final double longitude;

    Station({
      required this.id,
      required this.name,
      required this.docks,
      required this.location,
      required this.latitude,
      required this.longitude,
    });
  }