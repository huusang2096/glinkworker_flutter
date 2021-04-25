part of 'offer_cubit.dart';

class OfferState {
  List<PromoList> response;
  bool isLoading = false;

  OfferState({this.response, this.isLoading = false});

  OfferState.from(OfferState state) {
    this.response = state.response;
    this.isLoading = state.isLoading;
  }
  OfferState copyWith({List<PromoList> response, bool isLoading}) {
    return OfferState(
        response: response ?? this.response,
        isLoading: isLoading ?? this.isLoading);
  }
}

class OfferInitial extends OfferState {
  OfferInitial() : super(response: null);
}

class GetOfferFetch extends OfferState {
  GetOfferFetch(List<PromoList> response) : super(response: response);
}

class OfferFailState extends OfferState {
  final String message;

  OfferFailState(this.message) : super(response: null);
}
