part of 'home_cubit.dart';

class HomeState {
  List<ServicesResponse> listServices;
  String userName;
  HomeState(this.listServices, this.userName);
}

class HomeInitial extends HomeState {
  HomeInitial() : super([], "");
}

class HomeFetchingData extends HomeState {
  HomeFetchingData(List<ServicesResponse> response, String name)
      : super(response, name);
}
