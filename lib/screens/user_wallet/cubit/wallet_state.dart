part of 'wallet_cubit.dart';

class WalletState {
  UserWalletResponse userWallet;
  bool isLoading = false;
  WalletState({this.userWallet, this.isLoading = false});
  WalletState.from(WalletState state) {
    this.userWallet = state.userWallet;
    this.isLoading = state.isLoading;
  }
  WalletState copyWith({UserWalletResponse userWallet, bool isLoading}) {
    return WalletState(
        userWallet: userWallet ?? this.userWallet,
        isLoading: isLoading ?? this.isLoading);
  }
}

class WalletInitial extends WalletState {
  WalletInitial() : super();
}

class WalletFetchState extends WalletState {
  WalletFetchState(UserWalletResponse userWallet)
      : super(userWallet: userWallet);
}
