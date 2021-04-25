import 'package:flutter_map_booking/model/login_request.dart';
import 'package:flutter_map_booking/model/profile_response.dart';
import 'package:simplest/simplest.dart';

class AppPref extends BasePrefs {
  static Future<AppPref> instance() async {
    final _appPref = AppPref();
    await _appPref.init();
    return _appPref;
  }

  String get token {
    return getValueForKey(PrefKey.token);
  }

  setToken(String token) {
    return setValueForKey(PrefKey.token, token);
  }

  Future<void> logout() async {
    await setToken('');
    this.userName = null;
  }

  set userId(String userId) {
    setValueForKey(PrefKey.userId, userId);
  }

  String get userId {
    return getValueForKey(PrefKey.userId);
  }

  set fcmToken(String token) {
    setValueForKey(PrefKey.fcmToken, token);
  }

  String get fcmToken {
    return getValueForKey(PrefKey.fcmToken) ?? '';
  }

  LoginRequest get loginRequest {
    final jsonStr = getValueForKey(PrefKey.loginRequest);
    if (jsonStr == null || jsonStr.isEmpty) {
      return null;
    }
    return LoginRequest.fromRawJson(jsonStr);
  }

  set loginRequest(LoginRequest request) {
    if (request == null) {
      prefs.remove(PrefKey.loginRequest);
      return;
    }

    setValueForKey(PrefKey.loginRequest, request);
  }

  String get userName {
    final name = getValueForKey(PrefKey.userName);
    if (name == null || name.isEmpty) {
      return null;
    }
    return name;
  }

  set userName(String name) {
    if (name == null) {
      prefs.remove(PrefKey.userName);
      return;
    }
    setValueForKey(PrefKey.userName, name);
  }

  String get langCode => getValueForKey(PrefKey.langCode) ?? 'vi';
  set langCode(String code) => setValueForKey(PrefKey.langCode, code);

  ProfileResponse get userProfile {
    final savedJson = getValueForKey(PrefKey.userProfile);
    if (savedJson != null) {
      return ProfileResponse.fromRawJson(savedJson);
    }
    return null;
  }

  set userProfile(ProfileResponse profileResponse) {
    setValueForKey(PrefKey.userProfile, profileResponse);
  }
}

class PrefKey {
  static const String token = 'TOKEN';
  static const String fcmToken = 'FCM_TOKEN';
  static const String userId = 'USER_ID';
  static const String loginRequest = 'LOGIN_REQUEST';
  static const String userName = 'USER_NAME';
  static const String langCode = "LANG_CODE";
  static const String userProfile = 'USER_PROFILE';
}
