import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/home/cubit/home_cubit.dart';
import 'package:flutter_map_booking/screens/home/home_screen.dart';
import 'package:flutter_map_booking/screens/notification/cubit/notification_cubit.dart';
import 'package:flutter_map_booking/screens/notification/notification_screen.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/order_history_cubit.dart';
import 'package:flutter_map_booking/screens/order_history/order_history_screen.dart';
import 'package:flutter_map_booking/screens/profile/cubit/profile_cubit.dart';
import 'package:flutter_map_booking/screens/profile/profile_screen.dart';
import 'package:flutter_map_booking/screens/tab/cubit/tab_cubit.dart';
import 'package:flutter_map_booking/screens/tab/widgets/bottom_bar_item.dart';
import 'package:simplest/simplest.dart';

class TabScreen extends CubitWidget<TabCubit, TabState> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    HomeScreen.provider(),
    OrderHistoryScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  static provider(context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabCubit(),
        ),
        BlocProvider<OrderHistoryCubit>(
          create: (context) => OrderHistoryCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider<NotificationCubit>(
          create: (context) => NotificationCubit(),
        ),
      ],
      child: TabScreen(),
    );
  }

  @override
  Widget builder(BuildContext context, TabState state) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          backgroundColor: activeColor,
          onPressed: () {
            final homeCubit = context.bloc<HomeCubit>();
            if (homeCubit.state.listServices.length > 0)
              Navigator.of(context).pushNamed(AppRoute.viewAllServices,
                  arguments: {'services': homeCubit.state.listServices});
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        bottomNavigationBar: buildBottomNavigation(context, state),
        key: _scaffoldKey,
        body: IndexedStack(
          children: _screens,
          index: state.currentTab,
        ));
  }

  buildBottomNavigation(BuildContext context, TabState state) {
    return BottomAppBar(
      notchMargin: 5.0,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SizedBox(
                height: 60.0,
                child: Row(
                  children: [
                    BottomBarItem(
                      color: state.currentTab == 0
                          ? Color(0xffF34E3F)
                          : Color(0xff2B2929),
                      onPress: () {
                        bloc.changeCurrentTab(0);
                      },
                      title: 'home'.tr,
                      icon: Icons.home,
                    ),
                    BottomBarItem(
                      color: state.currentTab == 1
                          ? Color(0xffF34E3F)
                          : Color(0xff2B2929),
                      onPress: () {
                        context
                            .read<OrderHistoryCubit>()
                            .loadUserRequestHistory();
                        bloc.changeCurrentTab(1);
                      },
                      title: 'history'.tr,
                      icon: Icons.history,
                    ),
                  ],
                )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 5, //old: 4.5
          ),
          Expanded(
            child: SizedBox(
                height: 60.0,
                child: Row(
                  children: [
                    BottomBarItem(
                      color: state.currentTab == 2
                          ? Color(0xffF34E3F)
                          : Color(0xff2B2929),
                      onPress: () {
                        bloc.changeCurrentTab(2);
                      },
                      title: 'notification'.tr,
                      icon: Icons.message,
                    ),
                    BottomBarItem(
                      color: state.currentTab == 3
                          ? Color(0xffF34E3F)
                          : Color(0xff2B2929),
                      onPress: () {
                        bloc.changeCurrentTab(3);
                      },
                      title: 'profile'.tr,
                      icon: Icons.people,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  void listener(BuildContext context, TabState state) {
    super.listener(context, state);
    if (state is TabLogoutState) {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoute.loginScreen, (Route<dynamic> route) => false);
    }

    // TODO: TabPushBookingScreen???
    // if (state is TabPushBookingScreen) {
    //   Navigator.of(context).pushNamed(AppRoute.bookingScreen);
    // }
  }
}
