import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_wallet_response_model.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  @override
  initData() {}

  getUserWallet() async {
    try {
      emit(state.copyWith(isLoading: true));
      final userWallet = await dataRepository.getUserWallet();
      emit(state.copyWith(isLoading: true));
      if (userWallet != null) {
        emit(WalletFetchState(userWallet));
      } else {
        showErrorMessage('wallet_error');
      }
    } catch (e) {
      handleAppError(e);
    }
  }
}
