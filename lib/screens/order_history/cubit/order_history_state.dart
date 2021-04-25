part of 'order_history_cubit.dart';

class OrderHistoryState {
  List<UserRequestUpcomingHistoryResponse> upcoming;
  List<UserRequestHistoryResponse> past;
  RequestCheckResponse ongoing;
  String message;
  bool isLoading;
  OrderHistoryState(
      {this.upcoming,
      this.past,
      this.message,
      this.ongoing,
      this.isLoading = false});
  OrderHistoryState.from(OrderHistoryState state) {
    this.past = state.past;
    this.upcoming = state.upcoming;
    this.message = state.message;
    this.ongoing = state.ongoing;
    this.isLoading = state.isLoading;
  }

  OrderHistoryState copyWith(
      {List<UserRequestUpcomingHistoryResponse> upcoming,
      List<UserRequestHistoryResponse> past,
      bool isLoading,
      RequestCheckResponse ongoing,
      String message}) {
    return OrderHistoryState(
        message: message ?? this.message,
        past: past ?? this.past,
        upcoming: upcoming ?? this.upcoming,
        ongoing: ongoing ?? this.ongoing,
        isLoading: isLoading ?? this.isLoading);
  }
}

class OrderHistoryInitial extends OrderHistoryState {
  OrderHistoryInitial()
      : super(past: null, upcoming: null, message: null, ongoing: null);
}

class GetUserRequestHistoryFetch extends OrderHistoryState {
  GetUserRequestHistoryFetch(List<UserRequestUpcomingHistoryResponse> upcoming,
      List<UserRequestHistoryResponse> past, RequestCheckResponse ongoing)
      : super(upcoming: upcoming, past: past, ongoing: ongoing);
}

class CancelRequestState extends OrderHistoryState {
  CancelRequestState(String message, OrderHistoryState state)
      : super.from(state.copyWith(message: message));
}

class ReFreshDataState extends OrderHistoryState {
  ReFreshDataState(List<UserRequestUpcomingHistoryResponse> upcoming,
      List<UserRequestHistoryResponse> past, RequestCheckResponse ongoing)
      : super(upcoming: upcoming, past: past, ongoing: ongoing);
}
