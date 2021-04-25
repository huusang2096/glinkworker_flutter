part of 'upcoming_trip_cubit.dart';

class UpcomingTripState {
  List<UpcomingTripDetail> upcomingTripDetail;
  UpcomingTripState({this.upcomingTripDetail});

  UpcomingTripState.from(UpcomingTripState state) {
    this.upcomingTripDetail = state.upcomingTripDetail;
  }

  UpcomingTripState copyWith(
      {List<UpcomingTripDetail> upcomingTripDetail, String message}) {
    return UpcomingTripState(
        upcomingTripDetail: upcomingTripDetail ?? this.upcomingTripDetail);
  }
}

class UpcomingTripInitial extends UpcomingTripState {
  UpcomingTripInitial() : super(upcomingTripDetail: null);
}

class GetUpcomingTripDetail extends UpcomingTripState {
  GetUpcomingTripDetail(List<UpcomingTripDetail> upcomingTripDetail)
      : super(upcomingTripDetail: upcomingTripDetail);
}
