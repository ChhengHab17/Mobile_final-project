import 'package:final_project/model/dock.dart';
import 'package:final_project/ui/screens/station/widgets/bike_tile.dart';
import 'package:flutter/material.dart';

class StationContent extends StatelessWidget {
  const StationContent({super.key});
  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.location_on, color: Colors.orange, size: 42),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Station Name",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Station Location",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "5",
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
                              "1",
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
          itemCount: 20,
          itemBuilder: (context, index) {
            return BikeTile(
              dock: Dock(id: '${index + 1}', bikeId: '${index + 1}'),
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
