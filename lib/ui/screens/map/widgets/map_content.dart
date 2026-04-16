import 'package:final_project/model/station.dart';
import 'package:final_project/ui/screens/map/view_model/map_view_model.dart';
import 'package:final_project/ui/screens/map/widgets/station_marker.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key, required this.mapVm});
  final MapViewModel mapVm;

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Station>> stations = mapVm.stationsValue;

    switch (stations.state) {
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator());
      case AsyncValueState.error:
        return Center(child: Text('Error: ${stations.error}'));
      case AsyncValueState.success:
        return Scaffold(
          body: FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(11.55, 104.92),
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png",
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: "com.example.final_project",
              ),
              MarkerLayer(
                markers: stations.data!.map((station) =>
                  buildStationMarker(
                    station.latitude,
                    station.longitude,
                    station.availableBikes,
                    () => {},
                  )
                ).toList(),
              ),
            ],
          ),
        );
    }
  }
}
