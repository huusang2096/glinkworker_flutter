import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/cancel_booking_request.dart';
import 'package:flutter_map_booking/model/cancel_response.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_request_upcoming_history_response_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_request_history_response_model.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends BaseCubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  loadUserRequestHistory() async {
    try {
      emit(state.copyWith(isLoading: true));
      final past = await dataRepository.getUserRequesPasttHistory();
      final upcoming = await dataRepository.getUserRequesUpcomingHistory();
      final ongoing = await dataRepository.getRequestCheck();
      past.sort((a, b) => b.assignedAt.compareTo(a.assignedAt));
      upcoming.sort((a, b) => b.assignedAt.compareTo(a.assignedAt));
      emit(GetUserRequestHistoryFetch(upcoming, past, ongoing));
      emit(state.copyWith(isLoading: false));
    } catch (err) {
      emit(state.copyWith(isLoading: false));
      handleAppError(err);
    }
  }

  cancelRequest(CancelBookingRequest request) async {
    try {
      final CancelResponse response =
          await dataRepository.cancelBooking(request);
      if (response.status) {
        emit(CancelRequestState(response.message, state));
      } else {
        showErrorSnakeBar(response.message);
      }
    } catch (e) {
      parseDioError(e);
      handleError(e);
    }
  }

  refreshData() async {
    try {
      final past = await dataRepository.getUserRequesPasttHistory();
      final upcoming = await dataRepository.getUserRequesUpcomingHistory();
      final ongoing = await dataRepository.getRequestCheck();
      past.sort((a, b) => b.assignedAt.compareTo(a.assignedAt));
      upcoming.sort((a, b) => b.assignedAt.compareTo(a.assignedAt));
      emit(ReFreshDataState(upcoming, past, ongoing));
    } catch (err) {
      handleAppError(err);
    }
  }

  @override
  initData() {}
}
