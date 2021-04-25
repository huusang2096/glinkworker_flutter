part of 'booking_cubit.dart';

class BookingState {
  bool isDisableDetailAddress = false;
  bool isDisablePanel = false;
  bool isDisableBooking = true;
  bool isDisableGGMap = false;
  bool isShowLoadingSearch = false;
  Place myPlace;
  List<Place> listPlace;
  String statusSearch;
  ScheduleRequest scheduleRequest;
  List<ShowProviderResponse> listShowProvider;
  RequestCheckResponse requestCheckResponse;
  SendRequestResponse sendRequestResponse;
  String statusCheck;
  RateProviderRequest ratingRequest;
  CancelBookingRequest cancelRequest;
  int selectPayment;
  PromoList promo;
  List<UserRequestUpcomingHistoryResponse> upComingTrip;
  bool checkUseWallet;
  UserWalletResponse userWallet;
  LocationData locationData;
  List<CancelReasonResponse> cancelReason;
  int selectedCancelReason;
  bool isLoading = false;

  BookingState(
      this.isDisableDetailAddress,
      this.isDisablePanel,
      this.isDisableBooking,
      this.isDisableGGMap,
      this.isShowLoadingSearch,
      this.myPlace,
      this.listPlace,
      this.statusSearch,
      this.scheduleRequest,
      this.listShowProvider,
      this.requestCheckResponse,
      this.sendRequestResponse,
      this.statusCheck,
      this.ratingRequest,
      this.cancelRequest,
      this.selectPayment,
      this.promo,
      this.upComingTrip,
      this.checkUseWallet,
      this.userWallet,
      this.locationData,
      this.cancelReason,
      {this.selectedCancelReason = 0,
      this.isLoading = false});

  BookingState.fromState(BookingState state) {
    this.isDisableDetailAddress = state.isDisableDetailAddress;
    this.isDisablePanel = state.isDisablePanel;
    this.isDisableBooking = state.isDisableBooking;
    this.isDisableGGMap = state.isDisableGGMap;
    this.isShowLoadingSearch = state.isShowLoadingSearch;
    this.myPlace = state.myPlace;
    this.listPlace = state.listPlace;
    this.statusSearch = state.statusSearch;
    this.scheduleRequest = state.scheduleRequest;
    this.listShowProvider = state.listShowProvider;
    this.requestCheckResponse = state.requestCheckResponse;
    this.sendRequestResponse = state.sendRequestResponse;
    this.statusCheck = state.statusCheck;
    this.ratingRequest = state.ratingRequest;
    this.cancelRequest = state.cancelRequest;
    this.selectPayment = state.selectPayment;
    this.promo = state.promo;
    this.upComingTrip = state.upComingTrip;
    this.checkUseWallet = state.checkUseWallet;
    this.userWallet = state.userWallet;
    this.locationData = state.locationData;
    this.cancelReason = state.cancelReason;
    this.selectedCancelReason = state.selectedCancelReason;
    this.isLoading = state.isLoading;
  }

  BookingState.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck) {
    this.isDisableDetailAddress = state.isDisableDetailAddress;
    this.isDisablePanel = state.isDisablePanel;
    this.isDisableBooking = state.isDisableBooking;
    this.isDisableGGMap = state.isDisableGGMap;
    this.isShowLoadingSearch = state.isShowLoadingSearch;
    this.myPlace = state.myPlace;
    this.listPlace = state.listPlace;
    this.statusSearch = state.statusSearch;
    this.scheduleRequest = state.scheduleRequest;
    this.listShowProvider = listShowProvider;
    this.requestCheckResponse = requestCheckResponse;
    this.sendRequestResponse = state.sendRequestResponse;
    this.statusCheck = statusCheck;
    this.ratingRequest = state.ratingRequest;
    this.cancelRequest = state.cancelRequest;
    this.selectPayment = state.selectPayment;
    this.promo = state.promo;
    this.upComingTrip = state.upComingTrip;
    this.checkUseWallet = state.checkUseWallet;
    this.userWallet = state.userWallet;
    this.locationData = state.locationData;
    this.cancelReason = state.cancelReason;
    this.selectedCancelReason = state.selectedCancelReason;
  }

  BookingState.copyWith(
      {bool isDisableDetailAddress,
      bool isDisablePanel,
      bool isDisableBooking,
      bool isDisableGGMap,
      bool isShowLoadingSearch,
      Place myPlace,
      List<Place> listPlace,
      String statusSearch,
      ScheduleRequest scheduleRequest,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      SendRequestResponse sendRequestResponse,
      String statusCheck,
      RateProviderRequest ratingRequest,
      CancelBookingRequest cancelRequest,
      int selectPayment,
      PromoList promo,
      List<UserRequestUpcomingHistoryResponse> upComingTrip,
      bool checkUseWallet,
      UserWalletResponse userWallet,
      BookingState state,
      LocationData locationData,
      List<CancelReasonResponse> cancelReason,
      int selectedCancelReason,
      bool isLoading}) {
    this.isDisableDetailAddress =
        isDisableDetailAddress ?? state.isDisableDetailAddress;
    this.isDisablePanel = isDisablePanel ?? state.isDisablePanel;
    this.isDisableBooking = isDisableBooking ?? state.isDisableBooking;
    this.isDisableGGMap = isDisableGGMap ?? state.isDisableGGMap;
    this.isShowLoadingSearch = isShowLoadingSearch ?? state.isShowLoadingSearch;
    this.myPlace = myPlace ?? state.myPlace;
    this.listPlace = listPlace ?? state.listPlace;
    this.statusSearch = statusSearch ?? state.statusSearch;
    this.scheduleRequest = scheduleRequest ?? state.scheduleRequest;
    this.listShowProvider = listShowProvider ?? state.listShowProvider;
    this.requestCheckResponse =
        requestCheckResponse ?? state.requestCheckResponse;
    this.sendRequestResponse = sendRequestResponse ?? state.sendRequestResponse;
    this.statusCheck = statusCheck ?? state.statusCheck;
    this.ratingRequest = ratingRequest ?? state.ratingRequest;
    this.cancelRequest = cancelRequest ?? state.cancelRequest;
    this.selectPayment = selectPayment ?? state.selectPayment;
    this.promo = promo ?? state.promo;
    this.upComingTrip = upComingTrip ?? state.upComingTrip;
    this.checkUseWallet = checkUseWallet ?? state.checkUseWallet;
    this.userWallet = userWallet ?? state.userWallet;
    this.locationData = locationData ?? state.locationData;
    this.cancelReason = cancelReason ?? state.cancelReason;
    this.selectedCancelReason =
        selectedCancelReason ?? state.selectedCancelReason;
    this.isLoading = isLoading ?? state.isLoading;
  }
}

class BookingInitial extends BookingState {
  BookingInitial()
      : super(
            false,
            false,
            true,
            false,
            false,
            Place(),
            [],
            "NORMAL",
            ScheduleRequest(),
            [],
            RequestCheckResponse(),
            SendRequestResponse(),
            "EMPTY",
            RateProviderRequest(rating: 5, comment: ""),
            CancelBookingRequest(requestId: 0, cancelReason: ""),
            0,
            PromoList(),
            [],
            false,
            null,
            null,
            null);
}

class BookingCurrentLocation extends BookingState {
  BookingCurrentLocation(Place myPlace, BookingState state)
      : super.copyWith(
            myPlace: myPlace,
            listPlace: [],
            statusSearch: "NORMAL",
            state: state);
}

class BookingChangeMyLocation extends BookingState {
  BookingChangeMyLocation(Place fromPlace, BookingState state)
      : super.copyWith(
            myPlace: fromPlace,
            listPlace: [],
            statusSearch: "NORMAL",
            state: state);
}

class BookingSearchPlace extends BookingState {
  BookingSearchPlace(
      List<Place> listPlace, String statusSearch, BookingState state)
      : super.copyWith(
            listPlace: listPlace, statusSearch: statusSearch, state: state);
}

class BookingChangeStatusSearch extends BookingState {
  BookingChangeStatusSearch(String statusSearch, BookingState state)
      : super.copyWith(statusSearch: statusSearch, state: state);
}

class BookingChangeMyLocationInSearchTap extends BookingState {
  BookingChangeMyLocationInSearchTap(Place myPlace, BookingState state)
      : super.copyWith(myPlace: myPlace, state: state);
}

class BookingSchedule extends BookingState {
  BookingSchedule(ScheduleRequest scheduleRequest, BookingState state)
      : super.copyWith(scheduleRequest: scheduleRequest, state: state);
}

class BookingFetProviderAndRequest extends BookingState {
  BookingFetProviderAndRequest(
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck,
      BookingState state)
      : super.copyWith(
            listShowProvider: listShowProvider,
            requestCheckResponse: requestCheckResponse,
            statusCheck: statusCheck,
            state: state);
}

class BookingSendRequest extends BookingState {
  BookingSendRequest(
      SendRequestResponse sendRequestResponse, BookingState state)
      : super.copyWith(sendRequestResponse: sendRequestResponse, state: state);
}

class BookingDisableBooking extends BookingState {
  BookingDisableBooking(bool isDisableBooking, BookingState state)
      : super.copyWith(isDisableBooking: isDisableBooking, state: state);
}

class BookingDisableGGMap extends BookingState {
  BookingDisableGGMap(bool isDisableGGMap, BookingState state)
      : super.copyWith(isDisableGGMap: isDisableGGMap, state: state);
}

class BookingDisableDetailAddress extends BookingState {
  BookingDisableDetailAddress(bool isDisableDetailAddress, BookingState state)
      : super.copyWith(
            isDisableDetailAddress: isDisableDetailAddress, state: state);
}

class BookingDisablePanel extends BookingState {
  BookingDisablePanel(bool isDisablePanel, BookingState state)
      : super.copyWith(isDisablePanel: isDisablePanel, state: state);
}

class BookingShowLoadingSearch extends BookingState {
  BookingShowLoadingSearch(bool isShowLoadingSearch, BookingState state)
      : super.copyWith(isShowLoadingSearch: isShowLoadingSearch, state: state);
}

class BookingRateProvider extends BookingState {
  BookingRateProvider(bool isLoading, BookingState state)
      : super.copyWith(isLoading: isLoading, state: state);
}

class BookingUpdateRatingRequest extends BookingState {
  BookingUpdateRatingRequest(
      RateProviderRequest ratingRequest, BookingState state)
      : super.copyWith(ratingRequest: ratingRequest, state: state);
}

class BookingNotProviderAvailable extends BookingState {
  BookingNotProviderAvailable.fromState(BookingState state)
      : super.fromState(state);
}

class BookingFetRequestStatusTimeout extends BookingState {
  BookingFetRequestStatusTimeout.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingFetRequestStatusEmpty extends BookingState {
  BookingFetRequestStatusEmpty.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingFetRequestStatusSearching extends BookingState {
  BookingFetRequestStatusSearching.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingFetRequestStatusCancel extends BookingState {
  BookingFetRequestStatusCancel.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingFetRequestStatusStarted extends BookingState {
  BookingFetRequestStatusStarted.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingFetRequestStatusArrived extends BookingState {
  BookingFetRequestStatusArrived.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingRealTimeProviderGGMap extends BookingState {
  BookingRealTimeProviderGGMap(LocationData location, BookingState state)
      : super.copyWith(locationData: location, state: state);
}

class BookingFetRequestStatusPickedup extends BookingState {
  BookingFetRequestStatusPickedup.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingFetRequestStatusDropped extends BookingState {
  BookingFetRequestStatusDropped.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingFetRequestStatusCompleted extends BookingState {
  BookingFetRequestStatusCompleted.fetchingRequest(
      BookingState state,
      List<ShowProviderResponse> listShowProvider,
      RequestCheckResponse requestCheckResponse,
      String statusCheck)
      : super.fetchingRequest(
            state, listShowProvider, requestCheckResponse, statusCheck);
}

class BookingCancelReason extends BookingState {
  BookingCancelReason(CancelBookingRequest cancelRequest, BookingState state)
      : super.copyWith(cancelRequest: cancelRequest, state: state);
}

class BookingCancelSuccess extends BookingState {
  CancelResponse cancelResponse;

  BookingCancelSuccess(BookingState state, this.cancelResponse)
      : super.fromState(state);
}

class BookingSelectPayment extends BookingState {
  BookingSelectPayment(int selectPayment, BookingState state)
      : super.copyWith(selectPayment: selectPayment, state: state);
}

class BookingSelectPromo extends BookingState {
  BookingSelectPromo(PromoList promo, BookingState state)
      : super.copyWith(promo: promo, state: state);
}

class BookingUpComingTrip extends BookingState {
  BookingUpComingTrip(
      List<UserRequestUpcomingHistoryResponse> upComingTrip, BookingState state)
      : super.copyWith(upComingTrip: upComingTrip, state: state);
}

class BookingChangeUseWallet extends BookingState {
  BookingChangeUseWallet(
      bool checkUseWallet, UserWalletResponse userWallet, BookingState state)
      : super.copyWith(
            checkUseWallet: checkUseWallet,
            userWallet: userWallet,
            state: state);
}

class BookingGetCancelReason extends BookingState {
  BookingGetCancelReason(
      List<CancelReasonResponse> cancelReason, BookingState state)
      : super.copyWith(cancelReason: cancelReason, state: state);
}

class SelectCancelReason extends BookingState {
  SelectCancelReason(int selectedCancelReason, BookingState state)
      : super.copyWith(
            selectedCancelReason: selectedCancelReason, state: state);
}
