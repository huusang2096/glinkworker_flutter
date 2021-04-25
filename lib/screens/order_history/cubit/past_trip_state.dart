part of 'past_trip_cubit.dart';

class PastTripState {
  List<PastTripDetail> pastTripDetail;
  List<DisputeListResponse> disputeList;
  int selectedDispute;
  String message;
  bool isLoading = false;

  PastTripState(
      {this.pastTripDetail,
      this.disputeList,
      this.selectedDispute,
      this.message,
      this.isLoading = false});

  PastTripState copywith(
      {PastTripDetail pastTripDetail,
      List<DisputeListResponse> disputeList,
      int selectedDispute,
      String message,
      bool isLoading}) {
    return PastTripState(
        pastTripDetail: pastTripDetail ?? this.pastTripDetail,
        disputeList: disputeList ?? this.disputeList,
        selectedDispute: selectedDispute ?? this.selectedDispute,
        message: message ?? this.message,
        isLoading: isLoading ?? this.isLoading);
  }

  PastTripState.from(PastTripState state) {
    this.pastTripDetail = state.pastTripDetail;
    this.disputeList = state.disputeList;
    this.selectedDispute = state.selectedDispute;
    this.isLoading = state.isLoading;
  }
}

class PastTripInitial extends PastTripState {
  PastTripInitial() : super(pastTripDetail: null, disputeList: null);
}

class GetPastTripDetailState extends PastTripState {
  GetPastTripDetailState(List<PastTripDetail> pastTripDetail,
      List<DisputeListResponse> disputeList, PastTripState state)
      : super(pastTripDetail: pastTripDetail, disputeList: disputeList);
}

class SelectedDispute extends PastTripState {
  SelectedDispute(int selectedDispute, PastTripState state)
      : super.from(state.copywith(selectedDispute: selectedDispute));
}

class DisputeSuccess extends PastTripState {
  DisputeSuccess(String message, PastTripState state)
      : super(message: message, pastTripDetail: state.pastTripDetail);
}

class ReportLostItem extends PastTripState {
  ReportLostItem(String message, PastTripState state)
      : super(message: message, pastTripDetail: state.pastTripDetail);
}
