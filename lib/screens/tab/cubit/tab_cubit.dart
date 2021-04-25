import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/services/trip_service.dart';

part 'tab_state.dart';

class TabCubit extends BaseCubit<TabState> {
  TabCubit() : super(TabInitial());

  final tripService = locator<TripService>();

  @override
  initData() {
    // firstRequestCheck();
    tripService.startService(appPref.userProfile.id);
  }

  // firstRequestCheck() async {
  //   await tripService.firstRequestCheck().then((value) {
  //     if (tripService.getStatus != TripStatus.EMPTY) {
  //       if (tripService.isStopAutoCheck == true) {
  //         tripService.turnOnAutoRequestCheck();
  //         tripService.autoRequestCheck();
  //       }
  //     }
  //   });
  // }

  changeCurrentTab(int index) {
    emit(TabChangeScreenState(index));
  }

  logout() async {
    emit(TabLogoutState(state));
  }
}
