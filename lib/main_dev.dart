import 'package:final_project/data/repositories/bike/bike_repository.dart';
import 'package:final_project/data/repositories/bike/bike_repository_firebase.dart';
import 'package:final_project/data/repositories/station/station_repository.dart';
import 'package:final_project/data/repositories/station/station_repository_firebase.dart';
import 'package:final_project/main_common.dart';
import 'package:provider/provider.dart';


List<InheritedProvider> get devProviders{
  return [
    Provider<StationRepository>(create: (_) => StationRepositoryFirebase()),
    Provider<BikeRepository>(create: (_) => BikeRepositoryFirebase())
  ];
}
void main(){
  mainCommon(devProviders);
}