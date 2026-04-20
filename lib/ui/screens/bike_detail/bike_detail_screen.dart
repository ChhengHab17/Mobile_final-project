import 'package:final_project/data/repositories/bike/bike_repository.dart';
import 'package:final_project/model/dock.dart';
import 'package:final_project/model/station.dart';
import 'package:final_project/ui/screens/bike_detail/view_model/bike_detail_view_model.dart';
import 'package:final_project/ui/screens/bike_detail/widgets/bike_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BikeDetailScreen extends StatelessWidget {
  const BikeDetailScreen({
    super.key,
    required this.station,
    required this.dock,
  });

  final Station station;
  final Dock dock;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BikeDetailViewModel(
        bikeRepository: context.read<BikeRepository>(),
        station: station,
        dock: dock,
      ),
      child: Consumer<BikeDetailViewModel>(
        builder: (context, bikeDetailVm, child) {
          return BikeDetailContent(bikeDetailVm: bikeDetailVm);
        },
      ),
    );
  }
}