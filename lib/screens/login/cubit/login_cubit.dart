import 'dart:developer';

import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/model/login_request.dart';
import 'package:flutter_map_booking/model/login_response.dart';
import 'package:simplest/simplest.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit({Map<String, dynamic> agrs}) : super(LoginInitial(agrs: agrs));

  layoutInitialized() {
    if (state.agrs != null && state.agrs.containsKey('force_logout_message')) {
      final message = state.agrs['force_logout_message'];
      Get.snackbar(kAppName, message.tr);
    }
    checkSavedCretidential();
  }

  submitLogin({String email, PhoneNumber phoneNumber, String password}) async {
    LoginRequest request = LoginRequest();

    if (state.isCheckLoginByPhone) {
      request.mobile = phoneNumber.parseNumber();
      request.countryCode = phoneNumber.dialCode;
    } else {
      request.username = email;
    }
    request.deviceId = await DeviceHelper.deviceId;
    request.deviceToken = appPref.fcmToken;
    request.deviceType = DeviceHelper.deviceType;
    request.password = password;
    request.clientId = CLIENT_ID;
    request.clientSecret = CLIENT_SECRET;
    request.grantType = 'password';
    try {
      emit(state.copyWith(isLoading: true));
      LoginResponse loginResponse = await dataRepository.login(request);
      await appPref
          .setToken("${loginResponse.tokenType} ${loginResponse.accessToken}");
      log("appToken" + appPref.token.toString());
      dataRepository.loadAuthHeader();
      appPref.loginRequest = state.isCheckSaveAccount ? request : null;
      final userProfile = await dataRepository.getProfile();
      appPref.userProfile = userProfile;
      emit(state.copyWith(isLoading: false));
      emit(LoginSuccessState(state));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      handleAppError("unable_to_login");
    }
  }

  toggleRememberMe() {
    bool _isCheckSaveAccount = !state.isCheckSaveAccount;
    emit(ToggleRemberMeState(state, _isCheckSaveAccount));
  }

  toggleLoginByPhone() {
    bool _isCheckLoginByPhone = !state.isCheckLoginByPhone;
    emit(ToggleLoginByPhoneState(state, _isCheckLoginByPhone));
  }

  checkSavedCretidential() {
    final oldRequest = appPref.loginRequest;
    if (oldRequest == null) {
      return;
    }
    final _isUsePhone = oldRequest.username == null;
    emit(ShowSavedCredential(
        loginRequest: oldRequest,
        isCheckLoginByPhone: _isUsePhone,
        isCheckSaveAccount: true,
        state: state));
  }
}
