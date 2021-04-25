part of 'notification_cubit.dart';

class NotificationState {
  List<NotificationResponse> notificationResponses;

  NotificationState(this.notificationResponses);
}

class NotificationInitial extends NotificationState {
  NotificationInitial() : super(null);
}

class GetNotificationSuccessState extends NotificationState {
  GetNotificationSuccessState(List<NotificationResponse> notificationResponse)
      : super(notificationResponse);
}

class NotificationErrorState extends NotificationState {
  String errorMessage;

  NotificationErrorState(this.errorMessage, NotificationState state)
      : super(state.notificationResponses);
}
