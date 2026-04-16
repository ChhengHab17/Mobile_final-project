import 'package:final_project/ui/screens/map/view_model/map_view_model.dart';
import 'package:final_project/ui/screens/map/widgets/map_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapViewModel(stationRepository: context.read()),
      child: Consumer<MapViewModel>(
        builder: (context, mapVm, child) => MapContent(mapVm: mapVm),
      ),
    );
  }
}
