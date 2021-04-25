import 'dart:developer';

import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:simplest/simplest.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  @override
  initData() {}

  setup() async {
    _handleNotifcation();
  }

  _handleNotifcation() async {
    final _notifService = locator<NotificationService>();
    _notifService.requestPermission();
    log('fcmToken \n ${_notifService.fcmToken}');
    subscriptions.add(_notifService.dataStream.listen((data) {
      logger.i(data);
    }));
  }

  Future<void> fetchingData() async {
    try {
      final response = await dataRepository.getServices();
      emit(HomeFetchingData(response, state.userName));
    } catch (e) {
      handleAppError(e);
      parseDioError(e);
    }
  }

  copyData(List<ServicesResponse> list) {
    emit(HomeFetchingData(list, state.userName));
  }

  getNameUser() async {
    try {
      final name = appPref.userName;
      if (name != null) {
        emit(HomeFetchingData(state.listServices, name));
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
