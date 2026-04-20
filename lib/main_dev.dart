import 'package:final_project/data/repositories/bike/bike_repository.dart';
import 'package:final_project/data/repositories/bike/bike_repository_firebase.dart';
import 'package:final_project/data/repositories/station/station_repository.dart';
import 'package:final_project/data/repositories/station/station_repository_firebase.dart';
import 'package:final_project/data/repositories/subscription_plan/subscription_plan_firebase.dart';
import 'package:final_project/data/repositories/subscription_plan/subscription_plan_repository.dart';
import 'package:final_project/main_common.dart';
import 'package:final_project/ui/state/booking_state.dart';
import 'package:final_project/ui/state/subscription_state.dart';
import 'package:provider/provider.dart';


List<InheritedProvider> get devProviders{
  return [
    ChangeNotifierProvider<UserPassState>(create: (_) => UserPassState()),
    ChangeNotifierProvider<BookingState>(create: (_) => BookingState()),
    Provider<StationRepository>(create: (_) => StationRepositoryFirebase()),
    Provider<BikeRepository>(create: (_) => BikeRepositoryFirebase()),
    Provider<SubscriptionRepository>(
      create: (_) => SubscriptionRepositoryFirebase(),
    ),
  ];
}
void main(){
  mainCommon(devProviders);
}