import 'package:final_project/data/repositories/station/station_repository.dart';
import 'package:final_project/ui/screens/station/view_model/station_view_model.dart';
import 'package:final_project/ui/screens/station/widgets/station_content.dart';
import 'package:final_project/ui/state/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StationScreen extends StatelessWidget {
  const StationScreen({super.key, required this.stationId});
  final String stationId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StationViewModel(
        stationRepository: context.read<StationRepository>(),
        stationId: stationId,
      ),
      child: Consumer2<StationViewModel, BookingState>(
        builder: (context, stationVm, bookingState, child) {
          return StationContent(
            stationVm: stationVm,
            bookingState: bookingState,
          );
        },
      ),
    );
  }
}
