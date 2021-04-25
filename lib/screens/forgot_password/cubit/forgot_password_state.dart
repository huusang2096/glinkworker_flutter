part of 'forgot_password_cubit.dart';

class ForgotPasswordState {
  bool isPasswordObsecure;
  bool isConfirmObsecure;
  bool isPhoneVerified;
  bool isLoading = false;
  ForgotPasswordState(
      this.isPasswordObsecure, this.isConfirmObsecure, this.isPhoneVerified,
      {this.isLoading = false});

  ForgotPasswordState.from(ForgotPasswordState state) {
    this.isPasswordObsecure = state.isPasswordObsecure;
    this.isPhoneVerified = state.isPhoneVerified;
    this.isConfirmObsecure = state.isConfirmObsecure;
    this.isLoading = state.isLoading;
  }

  ForgotPasswordState copyWith(
      {bool isPasswordObsecure,
      bool isConfirmObsecure,
      bool isPhoneVerified,
      bool isLoading = false}) {
    return ForgotPasswordState(
      isPasswordObsecure ?? this.isPasswordObsecure,
      isConfirmObsecure ?? this.isConfirmObsecure,
      isPhoneVerified ?? this.isPhoneVerified,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ForgotPasswordInitial extends ForgotPasswordState {
  ForgotPasswordInitial() : super(true, true, false);
}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  ForgotPasswordSuccessState(ForgotPasswordState state)
      : super(state.isPasswordObsecure, state.isConfirmObsecure,
            state.isPhoneVerified);
}

class ForgotPasswordFailState extends ForgotPasswordState {
  final String message;
  ForgotPasswordFailState(
      this.message, ForgotPasswordState state, bool isPhoneVerified)
      : super(
            state.isPasswordObsecure, state.isConfirmObsecure, isPhoneVerified);
}

class ForgotPasswordUpdateObsecurePassState extends ForgotPasswordState {
  ForgotPasswordUpdateObsecurePassState(bool isPasswordObsecure,
      bool isConfirmObsecure, ForgotPasswordState state)
      : super(isPasswordObsecure, isConfirmObsecure, state.isPhoneVerified);
}

class ForgotPasswordVerifyPhoneState extends ForgotPasswordState {
  String verificationId;
  String phoneNumber;
  ForgotPasswordVerifyPhoneState(
      ForgotPasswordState state, this.verificationId, this.phoneNumber)
      : super(
          state.isPasswordObsecure,
          state.isConfirmObsecure,
          state.isPhoneVerified,
        );
}
