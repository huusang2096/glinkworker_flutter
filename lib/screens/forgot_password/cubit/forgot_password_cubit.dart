import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/forgot_password_request.dart';
import 'package:simplest/simplest.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  final PhoneAuthService _phoneAuthService = locator<PhoneAuthService>();

  submitReset({
    PhoneNumber phoneNumber,
    String password,
    String confirmPassword,
  }) async {
    try {
      phoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
          phoneNumber.phoneNumber);
    } catch (err) {
      showErrorMessage('invalid_phone_number'.tr);
      return;
    }

    if (password.length < 6) {
      showErrorMessage('passsword_requirement'.tr);
      return;
    }

    if (password != confirmPassword) {
      showErrorMessage('passsword_does_not_match'.tr);
      return;
    }
    try {
      final verifyResponse =
          await _phoneAuthService.verifyPhoneNumber(phoneNumber.phoneNumber);
      final phone = (await PhoneNumber.getParsableNumber(phoneNumber))
          .replaceAll(" ", "");
      final _dialCodePhone = phoneNumber.dialCode.replaceAll("+", "");
      final _countryCode = '+$_dialCodePhone';
      emit(state.copyWith(isLoading: true));
      await dataRepository.resetPassword(ForgotPasswordRequest(
          verifyToken: verifyResponse.verifyToken,
          mobile: phone,
          countryCode: _countryCode,
          password: password,
          passwordConfirmation: confirmPassword));
      emit(state.copyWith(isLoading: false));
      emit(ForgotPasswordSuccessState(state));
    } catch (e) {
      handleAppError(e);
    }
  }

  @override
  initData() {}

  touchShowPassword() {
    emit(ForgotPasswordUpdateObsecurePassState(
        !state.isPasswordObsecure, state.isConfirmObsecure, state));
  }

  touchShowPasswordAgain() {
    emit(ForgotPasswordUpdateObsecurePassState(
        state.isPasswordObsecure, !state.isConfirmObsecure, state));
  }
}
