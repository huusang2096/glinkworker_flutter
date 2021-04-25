import 'package:flutter_map_booking/common/storage/app_prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simplest/simplest.dart';

import 'locator.config.dart';
import 'services/trip_service.dart';

GetIt locator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() => $initGetIt(locator);

@module
abstract class StackedServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackBarService;
}

@module
abstract class SimplestServicesModule {
  @lazySingleton
  LoadingService get loadingService;
  @lazySingleton
  LocationService get locationService;
  @lazySingleton
  NetworkActivityService get networkActivityService;
  @preResolve
  Future<NotificationService> get notificationService =>
      NotificationService.init();
  @lazySingleton
  PhoneAuthService get phoneAuthService;
  @lazySingleton
  MediaService get mediaService;
}

@module
abstract class AppModule {
  @preResolve
  Future<AppPref> get appPrefs => AppPref.instance();
  @lazySingleton
  TripService get tripService;
}
