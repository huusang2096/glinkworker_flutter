part of 'service_cubit.dart';

class ServiceState {
  int selectTon;
  int amount;
  ServiceState(this.selectTon, this.amount);
}

class ServiceInitial extends ServiceState {
  ServiceInitial() : super(0, 1);
}

class ChangeSelectTon extends ServiceState {
  ChangeSelectTon(int selectTon, ServiceState state)
      : super(selectTon, state.amount);
}

class ChangeAmount extends ServiceState {
  ChangeAmount(ServiceState state, int amount) : super(state.selectTon, amount);
}
