import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/screens/order_history/models/upcoming_trip_detail_response_model.dart';
part 'upcoming_trip_state.dart';

class UpcomingTripCubit extends BaseCubit<UpcomingTripState> {
  UpcomingTripCubit() : super(UpcomingTripInitial());

  getUpcomingTripDetail(int requestId) async {
    try {
      final List<UpcomingTripDetail> response =
          await dataRepository.getUpcomingTripDetail(requestId);
      emit(GetUpcomingTripDetail(response));
    } catch (e) {
      handleAppError(e);
    }
  }
}
