part of 'sign_up_cubit.dart';

class SignUpState {
  bool isPasswordObsecure;
  bool isConfirmObsecure;
  bool isCheckSaveAccount;
  bool isPhoneVerified;
  bool isLoading = false;

  SignUpState(this.isPasswordObsecure, this.isConfirmObsecure,
      this.isCheckSaveAccount, this.isPhoneVerified,
      {this.isLoading = false});

  SignUpState copyWith({
    bool isPasswordObsecure,
    bool isConfirmObsecure,
    bool isCheckSaveAccount,
    bool isPhoneVerified,
    bool isLoading,
  }) {
    return SignUpState(
        isPasswordObsecure ?? this.isPasswordObsecure,
        isConfirmObsecure ?? this.isConfirmObsecure,
        isCheckSaveAccount ?? this.isCheckSaveAccount,
        isPhoneVerified ?? this.isPhoneVerified,
        isLoading: isLoading ?? this.isLoading);
  }

  SignUpState.from(SignUpState state) {
    this.isPasswordObsecure = state.isPasswordObsecure;
    this.isConfirmObsecure = state.isConfirmObsecure;
    this.isCheckSaveAccount = state.isCheckSaveAccount;
    this.isPhoneVerified = state.isPhoneVerified;
    this.isLoading = state.isLoading;
  }
}

class SignUpInitial extends SignUpState {
  SignUpInitial() : super(true, true, false, false);
}

class SignUpSuccessState extends SignUpState {
  final RegisterResponse registerResponse;
  SignUpSuccessState(this.registerResponse, SignUpState state)
      : super.from(state);
}

class SignUpFailState extends SignUpState {
  final String message;
  SignUpFailState(this.message, SignUpState state) : super.from(state);
}

class SignUpUpdateObsecurePassState extends SignUpState {
  SignUpUpdateObsecurePassState(
      bool isPasswordObsecure, bool isConfirmObsecure, SignUpState state)
      : super.from(state.copyWith(
          isPasswordObsecure: isPasswordObsecure,
          isConfirmObsecure: isConfirmObsecure,
        ));
}

class SignUpUpdateCheckboxSaveAccount extends SignUpState {
  SignUpUpdateCheckboxSaveAccount(SignUpState state, bool isCheckSaveAccount)
      : super.from(state.copyWith(isCheckSaveAccount: isCheckSaveAccount));
}
