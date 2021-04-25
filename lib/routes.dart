import 'package:flutter/material.dart';
import 'package:flutter_map_booking/screens/booking/booking_screen.dart';
import 'package:flutter_map_booking/screens/booking/search_place_screen.dart';
import 'package:flutter_map_booking/screens/chat/chat_screen.dart';
import 'package:flutter_map_booking/screens/checkout/check_out_screen.dart';
import 'package:flutter_map_booking/screens/forgot_password/forgot_password_screen.dart';
import 'package:flutter_map_booking/screens/languages/languages_screen.dart';
import 'package:flutter_map_booking/screens/message/message_screen.dart';
import 'package:flutter_map_booking/screens/offer/offer_screen.dart';
import 'package:flutter_map_booking/screens/order_history/complete_task_screen.dart';
import 'package:flutter_map_booking/screens/order_history/schedule_history_request_detail.dart';
import 'package:flutter_map_booking/screens/order_history/past_history_request_detail.dart';
import 'package:flutter_map_booking/screens/profile/edit_profile.dart';
import 'package:flutter_map_booking/screens/profile/profile_screen.dart';
import 'package:flutter_map_booking/screens/services/all_services_screen.dart';
import 'package:flutter_map_booking/screens/services/book_time_service_screen.dart';
import 'package:flutter_map_booking/screens/services/repair_service_screen.dart';
import 'package:flutter_map_booking/screens/tab/tab_screen.dart';
import 'package:flutter_map_booking/screens/user_wallet/user_payment_screen.dart';
import 'package:flutter_map_booking/screens/user_wallet/wallet_screen.dart';

import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/splash/splash_screen.dart';

class PageViewTransition<T> extends MaterialPageRoute<T> {
  PageViewTransition({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') return child;
    if (animation.status == AnimationStatus.reverse)
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}

class AppRoute {
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String forgotPasswordScreen = '/forgotPassword';
  static const String profileScreen = '/profile';
  static const String editProfileScreen = '/editProfile';
  static const String walletScreen = '/walletScreen';
  static const String repairService = '/repairService';
  static const String bookTimeServiceScreen = '/bookTimeServiceScreen';
  static const String bookingScreen = '/bookingScreen';
  static const String tabScreen = '/tabScreen';
  static const String historyScreen = '/historyScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String viewAllServices = 'viewAllServices';
  static const String searchPlaceScreen = '/searchPlaceScreen';
  static const String paymentScreen = '/paymentScreen';
  static const String offerScreen = '/offerScreen';
  static const String completetaskScreen = '/completedTaskScreen';
  // static const String addCardScreen = '/addCardScreen';
  static const String messageScreen = '/messageScreen';
  static const String languagesScreen = '/languagesScreen';
  static const String pastTripHistoryDetailScreen =
      'pastTripHistoryDetailScreen';
  static const String upcomingTripHistoryDetailScreen =
      'upcomingTripHistoryDetailScreen';
  static const String chatScreen = '/chatScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final agrs = settings.arguments as Map<String, dynamic> ?? {};
    switch (settings.name) {
      case '/':
      case splashScreen:
        return PageViewTransition(builder: (_) => SplashScreen());
      case loginScreen:
        return PageViewTransition(
            builder: (context) => LoginScreen.provider(context, agrs: agrs),
            settings: settings);
      case profileScreen:
        return PageViewTransition(
          builder: (context) => ProfileScreen.provider(agrs['profileResponse']),
          settings: settings,
        );
      case editProfileScreen:
        return PageViewTransition(
            builder: (context) => EditProfile.provider(), settings: settings);
      case signUpScreen:
        return PageViewTransition(
            builder: (_) => SignupScreen.provider(), settings: settings);
      case forgotPasswordScreen:
        return PageViewTransition(
            builder: (_) => ForgotPasswordScreen.provider(),
            settings: settings);
      case walletScreen:
        return PageViewTransition(
            builder: (_) => WalletScreen.provider(), settings: settings);
        return PageViewTransition(
            builder: (_) => SignupScreen.provider(), settings: settings);
      case repairService:
        return PageViewTransition(
            builder: (_) => RepairServiceScreen.provider(agrs['idService'],
                listServices: agrs['listServices'],
                navigationBooking: agrs['navigationBooking']));
      case bookTimeServiceScreen:
        final sendRequest = agrs['sendRequest'];
        return PageViewTransition(
            builder: (_) => BookTimeServiceScreen.provider(
                service: agrs['item'],
                ton: agrs['ton'],
                amount: agrs['amount'],
                sendRequest: sendRequest),
            settings: settings);
      case bookingScreen:
        return PageViewTransition(
            builder: (_) => BookingScreen.provider(agrs['service']),
            settings: settings);
      case tabScreen:
        return PageViewTransition(
            settings: settings,
            builder: (context) => TabScreen.provider(context));
      case offerScreen:
        return PageViewTransition(
            settings: settings,
            builder: (context) => OfferScreen.provider(
                context: context, disableTap: agrs['disable'] ?? true));
      case checkoutScreen:
        return PageViewTransition(builder: (_) => CheckOutScreen.provider());

      case searchPlaceScreen:
        return PageViewTransition(
          builder: (_) => SearchPlaceScreen.provider(agrs['cubit']),
          settings: settings,
        );
      case viewAllServices:
        return PageViewTransition(
          builder: (_) => AllServicesScreen.provider(agrs['services']),
          settings: settings,
        );
      case completetaskScreen:
        return PageViewTransition(
            builder: (_) => CompletedTaskScreen.provider(), settings: settings);

      case completetaskScreen:
        return PageViewTransition(
            builder: (_) => CompletedTaskScreen.provider(), settings: settings);
      case checkoutScreen:
        return PageViewTransition(builder: (_) => CheckOutScreen.provider());
      case paymentScreen:
        return PageViewTransition(
            builder: (_) => UserPaymentScreen.provider(
                amount: agrs['amount'] ?? 0, requestGoto: agrs['requestGoto']),
            settings: settings);
      // case addCardScreen:
      //   return PageViewTransition(
      //       builder: (_) => AddCardScreen.provider(amount: agrs['amount']));
      case messageScreen:
        return PageViewTransition(builder: (_) => MessageScreen.provider());
      case languagesScreen:
        return MaterialPageRoute(builder: (_) => LanguagesScreen.provider());
      case pastTripHistoryDetailScreen:
        return MaterialPageRoute(
            builder: (_) =>
                PastHistoryRequestDetailScreen.provider(agrs['requestId']));
      case upcomingTripHistoryDetailScreen:
        return MaterialPageRoute(
            builder: (_) =>
                UpcomingHistoryRequestDetailScreen.provider(agrs['requestId']));
      case chatScreen:
        return MaterialPageRoute(
            builder: (_) => ChatScreen.provider(agrs['trip']));
      default:
        return PageViewTransition(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
