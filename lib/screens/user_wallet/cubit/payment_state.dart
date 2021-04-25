part of 'payment_cubit.dart';

class PaymentState {
  List<UserCardResponse> userCard;
  UserAddMoneyResponse addMoneyResponse;
  BaseResponse message;
  PaymentState({this.userCard, this.addMoneyResponse, this.message});

  PaymentState.from(PaymentState state) {
    this.userCard = state.userCard;
    this.addMoneyResponse = state.addMoneyResponse;
    this.message = state.message;
  }

  PaymentState copyWith({
    List<UserCardResponse> userCard,
    UserAddMoneyResponse addMoneyResponse,
    BaseResponse message,
    bool requestGoto,
  }) {
    return PaymentState(
        userCard: userCard ?? this.userCard,
        message: message ?? this.message,
        addMoneyResponse: addMoneyResponse ?? this.addMoneyResponse);
  }
}

class PaymentInitial extends PaymentState {
  PaymentInitial() : super();
}

class PaymentDataFetch extends PaymentState {
  PaymentDataFetch(List<UserCardResponse> userCard, PaymentState state)
      : super(userCard: userCard);
}

class PaymentAddMoneySuccess extends PaymentState {
  PaymentAddMoneySuccess(
      UserAddMoneyResponse addMoneyResponse, PaymentState state)
      : super.from(state.copyWith(addMoneyResponse: addMoneyResponse));
}

class AddCardPaymentSuccessState extends PaymentState {
  AddCardPaymentSuccessState(
      List<UserCardResponse> userCard, BaseResponse message)
      : super(userCard: userCard, message: message);
}

class DeleteCardPaymentSuccess extends PaymentState {
  DeleteCardPaymentSuccess(
      List<UserCardResponse> userCard, BaseResponse message)
      : super(userCard: userCard, message: message);
}
