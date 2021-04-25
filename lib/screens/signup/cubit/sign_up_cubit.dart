import 'dart:async';
import 'dart:io';

import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/register_request.dart';
import 'package:flutter_map_booking/model/register_response.dart';
import 'package:simplest/simplest.dart';

part 'sign_up_state.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> loginOrRegister(
      PhoneNumber phoneNumber, RegisterRequest registerRequest) async {
    try {
      emit(state.copyWith(isLoading: true));
      final verifyResponse = await locator<PhoneAuthService>()
          .verifyPhoneNumber(phoneNumber.phoneNumber);
      emit(state.copyWith(isLoading: true));
      registerRequest.deviceType = Platform.operatingSystem.toString();
      registerRequest.deviceToken = "fcm";
      registerRequest.deviceId = "2";
      registerRequest.deviceType = DeviceHelper.deviceType;
      registerRequest.deviceToken =
          appPref.fcmToken.isNullOrBlank ? 'fcm_token' : appPref.fcmToken;
      registerRequest.deviceId = await DeviceHelper.deviceId;
      registerRequest.loginBy = "manual";
      registerRequest.verifyToken = verifyResponse.verifyToken;
      registerRequest.mobile = phoneNumber.parseNumber();
      registerRequest.countryCode = phoneNumber.dialCode;
      final registerResponse =
          await dataRepository.loginOrRegister(registerRequest);
      emit(state.copyWith(isLoading: false));
      snackbarService.showSnackbar(message: 'register_success'.tr);
      await Future.delayed(Duration(seconds: 2));
      emit(SignUpSuccessState(registerResponse, state));
    } catch (e) {
      handleAppError(e);
    }
    emit(state.copyWith(isLoading: false));
  }

  touchShowPassword() {
    emit(SignUpUpdateObsecurePassState(
        !state.isPasswordObsecure, state.isConfirmObsecure, state));
  }

  touchShowPasswordAgain() {
    emit(SignUpUpdateObsecurePassState(
        state.isPasswordObsecure, !state.isConfirmObsecure, state));
  }

  touchShowCheckboxSaveAccount() {
    bool isCheckSaveAccount = !state.isCheckSaveAccount;
    emit(SignUpUpdateCheckboxSaveAccount(state, isCheckSaveAccount));
  }
}
