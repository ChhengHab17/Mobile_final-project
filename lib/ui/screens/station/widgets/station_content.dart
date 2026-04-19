import 'package:final_project/model/station.dart';
import 'package:final_project/ui/screens/bike_detail/bike_detail_screen.dart';
import 'package:final_project/ui/screens/station/view_model/station_view_model.dart';
import 'package:final_project/ui/screens/station/widgets/bike_tile.dart';
import 'package:final_project/ui/utils/asyncvalue.dart';
import 'package:flutter/material.dart';

class StationContent extends StatelessWidget {
  const StationContent({super.key, required this.stationVm});
  final StationViewModel stationVm;

  @override
  Widget build(BuildContext context) {
    final AsyncValue<Station> station = stationVm.stationValue;

    switch (station.state) {
      case AsyncValueState.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AsyncValueState.error:
        return Scaffold(
          appBar: AppBar(
            title: const Text('Station Info'),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
          ),
          body: Center(child: Text('Error: ${station.error}')),
        );
      case AsyncValueState.success:
        final Station stationData = stationVm.currentStation;
        final int availableBikes = stationVm.availableBikes;
        final int availableParking = stationVm.availableParking;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            title: const Text('Station Info'),
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.orange,
                      size: 42,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          stationData.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          stationData.location,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '$availableBikes',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.pedal_bike_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Row(
                              children: [
                                Text(
                                  '$availableParking',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.local_parking_rounded,
                                  color: Colors.black,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: availableBikes,
              itemBuilder: (context, index) {
                return BikeTile(dock: stationData.docks[index], onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BikeDetailScreen(),
                    ),
                  );
                });
              },
            ),
          ),
        );
    }
  }
}
