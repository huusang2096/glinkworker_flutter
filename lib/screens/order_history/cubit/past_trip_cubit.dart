import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/model/dispute_response.dart';
import 'package:flutter_map_booking/screens/order_history/models/dispute_list_response_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/past_trip_detail_response_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/report_item_request_model.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_dispute_request_model.dart';

part 'past_trip_state.dart';

class PastTripCubit extends BaseCubit<PastTripState> {
  PastTripCubit() : super(PastTripInitial());

  getPastTripDetail(int requestId) async {
    try {
      emit(state.copywith(isLoading: true));
      final List<PastTripDetail> response =
          await dataRepository.getPastTripDetail(requestId);
      final List<DisputeListResponse> disputeList =
          await dataRepository.getDisputeList("user");
      print("DisputeName" + disputeList[0].disputeName);
      emit(GetPastTripDetailState(response, disputeList, state));
    } catch (e) {
      print("Error: " + e.toString());
      handleAppError(e);
    }
    emit(state.copywith(isLoading: false));
  }

  selectedDispute(int index) async {
    emit(SelectedDispute(index, state));
  }

  dispute(DisputeRequest request) async {
    try {
      final DisputeResponse response = await dataRepository.dispute(request);
      emit(DisputeSuccess(response.message, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  reportLostItem(ReportLostItemRequest request) async {
    try {
      final response = await dataRepository.reportLostItem(request);
      emit(ReportLostItem(response.message, state));
    } catch (e) {
      handleAppError(e);
    }
  }
}
