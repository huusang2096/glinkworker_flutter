import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/model/base_response.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_add_money_request_model.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_add_money_response_model.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_card_response_model.dart';
import 'package:simplest/simplest.dart';

part 'payment_state.dart';

class PaymentCubit extends BaseCubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  @override
  initData() {}

  getUserPayment() async {
    try {
      final response = await dataRepository.getCard();
      emit(PaymentDataFetch(response, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  addMoney(UserAddMoneyRequest userAddMoneyRequest) async {
    await showLoading();
    userAddMoneyRequest.userType = "user";
    userAddMoneyRequest.paymentMode = "CARD";
    try {
      final UserAddMoneyResponse response =
          await dataRepository.addMoney(userAddMoneyRequest);
      await hideLoading();
      emit(PaymentAddMoneySuccess(response, state));
    } catch (e) {
      handleAppError(e);
    }
  }

  setDefaultPaymentCard() async {}

  addCardPayment(String stripeToken) async {
    // emitLoading(true);
    try {
      final BaseResponse response = await dataRepository.addCard(stripeToken);
      // emitLoading(false);
      if (response.status == true) {
        emit(AddCardPaymentSuccessState(state.userCard, response));
      } else {
        showErrorMessage(response.message.tr);
      }
    } catch (e) {
      handleAppError(e);
    }
  }

  deleteCardPayment(String cardId, String method) async {
    await showLoading();
    try {
      final BaseResponse response =
          await dataRepository.deleteCard(cardId, method);
      await hideLoading();

      emit(DeleteCardPaymentSuccess(state.userCard, response));
    } catch (e) {
      handleAppError(e);
    }
  }
}
