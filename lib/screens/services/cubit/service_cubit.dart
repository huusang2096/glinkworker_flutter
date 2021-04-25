import 'package:flutter_map_booking/common/base_cubit.dart';

part 'service_state.dart';

class ServiceCubit extends BaseCubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());

  changeSelectTon(int index) {
    emit(ChangeSelectTon(index, state));
  }

  changeAmountIncrement() {
    final amount = state.amount;
    emit(ChangeAmount(state, amount + 1));
  }

  changeAmountDecrement() {
    final amount = state.amount;
    emit(ChangeAmount(state, amount - 1));
  }

  refreshInit() {
    emit(ServiceInitial());
  }
}
