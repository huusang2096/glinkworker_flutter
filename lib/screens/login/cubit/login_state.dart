part of 'login_cubit.dart';

class LoginState {
  bool isCheckSaveAccount;
  bool isCheckLoginByPhone;
  Map<String, dynamic> agrs;
  bool isLoading = false;

  LoginState(
      {this.isCheckLoginByPhone,
      this.isCheckSaveAccount,
      this.agrs,
      this.isLoading = false});

  LoginState copyWith(
      {bool isCheckSaveAccount,
      bool isCheckLoginByPhone,
      Map<String, dynamic> agrs,
      bool isLoading}) {
    return LoginState(
        isCheckLoginByPhone: isCheckLoginByPhone ?? this.isCheckLoginByPhone,
        isCheckSaveAccount: isCheckSaveAccount ?? this.isCheckSaveAccount,
        agrs: agrs ?? this.agrs,
        isLoading: isLoading ?? this.isLoading);
  }

  LoginState.from(LoginState state) {
    this.isCheckLoginByPhone = state.isCheckLoginByPhone;
    this.isCheckSaveAccount = state.isCheckSaveAccount;
    this.agrs = agrs;
    this.isLoading = isLoading;
  }
}

class LoginInitial extends LoginState {
  LoginInitial({Map<String, dynamic> agrs})
      : super(
            isCheckLoginByPhone: false, isCheckSaveAccount: false, agrs: agrs);
}

class LoginSuccessState extends LoginState {
  LoginSuccessState(LoginState state) : super.from(state);
}

class ToggleRemberMeState extends LoginState {
  ToggleRemberMeState(LoginState state, bool isCheckSaveAccount)
      : super.from(state.copyWith(isCheckSaveAccount: isCheckSaveAccount));
}

class ToggleLoginByPhoneState extends LoginState {
  ToggleLoginByPhoneState(LoginState state, bool isCheckLoginByPhone)
      : super.from(state.copyWith(isCheckLoginByPhone: isCheckLoginByPhone));
}

class ShowSavedCredential extends LoginState {
  final LoginRequest loginRequest;
  ShowSavedCredential(
      {this.loginRequest,
      bool isCheckLoginByPhone,
      bool isCheckSaveAccount,
      LoginState state})
      : super.from(state.copyWith(
          isCheckLoginByPhone: isCheckLoginByPhone,
          isCheckSaveAccount: isCheckSaveAccount,
        ));
}
