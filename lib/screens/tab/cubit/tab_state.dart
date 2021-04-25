part of 'tab_cubit.dart';

class TabState {
  int currentTab;
  TabState(this.currentTab);
}

class TabInitial extends TabState {
  TabInitial() : super(0);
}

class TabChangeScreenState extends TabState {
  TabChangeScreenState(int currentTab) : super(currentTab);
}

class TabLogoutState extends TabState {
  TabLogoutState(TabState state) : super(state.currentTab);
}
