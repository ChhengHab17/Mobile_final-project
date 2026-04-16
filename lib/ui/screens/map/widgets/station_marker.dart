import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

Marker buildStationMarker(
  double lat,
  double lng,
  int availableBikes,
  VoidCallback onTap,
) {
  return Marker(
    point: LatLng(lat, lng),
    width: 44,
    height: 50,
    child: GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.location_on, color: Colors.orange, size: 42),
          Positioned(
            top: 10,
            child: Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Text(
                '$availableBikes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
