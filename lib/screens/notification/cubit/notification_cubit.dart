import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/model/notification_response.dart';
import 'package:simplest/simplest.dart';

part 'notification_state.dart';

class NotificationCubit extends BaseCubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  getNotification() async {
    try {
      List<NotificationResponse> notificationResponse =
          await dataRepository.getListNotification();
      emit(GetNotificationSuccessState(notificationResponse));
    } catch (e) {
      handleAppError('get_notification_error');
      emit(NotificationErrorState(
          'get_notification_error'.tr, state)); // Notify to stop refresher
    }
  }
}
