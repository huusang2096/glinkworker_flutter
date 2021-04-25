import 'dart:async';

import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/repository/data_repository.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simplest/simplest.dart';

class PaymentStatus {
  static const String CASH = "CASH";
  static const String CARD = "CARD";
  static const String PAYPAL = "PAYPAL";
  static const String WALLET = "WALLET";
  static const String BRAINTREE = "BRAINTREE";
  static const String PAYUMONEY = "PAYUMONEY";
  static const String PAYTM = "PAYTM";

  static const String DEBIT_MACHINE = "DEBIT_MACHINE";
  static const String VOUCHER = "VOUCHER";
}

class TripStatus {
  static const String CANCEL = 'CANCEL';
  static const String ERROR = 'ERROR';
  static const String ACCEPTED = 'ACCEPTED';
  static const String EMPTY = 'EMPTY';
  static const String TIMEOUT = 'TIMEOUT';
  static const String SEARCHING = 'SEARCHING';
  static const String STARTED = 'STARTED';
  static const String ARRIVED = 'ARRIVED';
  static const String PICKEDUP = 'PICKEDUP';
  static const String DROPPED = 'DROPPED';
  static const String COMPLETED = 'COMPLETED';
  static const String PATCH = 'PATCH';
  static const String CANCELLED = 'CANCELLED';
  static const String SCHEDULED = 'SCHEDULED';
}

class TripService {
  bool isStopAutoCheck = true;
  bool _isBooking = false;
  // int _countStop = 0;

  // int get count => _countStop;

  // set count(int number) {
  //   this._countStop = this._countStop + number;
  //   if (this._countStop > 5) {
  //     this._countStop = 0;
  //   }
  // }

  bool get isBooking => _isBooking;

  set isBooking(bool check) {
    this._isBooking = check;
  }

  BehaviorSubject<Trip> _tripSubject = BehaviorSubject<Trip>();
  String get getStatus => _tripSubject.value?.status ?? TripStatus.EMPTY;
  RequestCheckResponse get getRequestCheckResponse =>
      _tripSubject.value?.requestCheckResponse ?? RequestCheckResponse();
  Datum get currentTrip => getRequestCheckResponse.data.firstOrNull;
  Stream<Trip> get tripStream => _tripSubject.stream;
  // StreamSubscription<Trip> _subscription;
  // Stream<Trip> get stream => _tripSubject.stream;
  DataRepository dataRepository = locator<DataRepository>();
  final _snackbarService = locator<SnackbarService>();
  // SnackbarConfig _config;
  final _locatorNavigation = locator<NavigationService>();
  StreamSubscription _tripSubscription;
  bool _getTripLocked = false;

  List<Map<String, dynamic>> _listCheckNotification = [
    {'status': TripStatus.TIMEOUT, 'isShow': false},
    {'status': TripStatus.ERROR, 'isShow': false},
    {'status': TripStatus.ACCEPTED, 'isShow': false},
    {'status': TripStatus.EMPTY, 'isShow': false},
    {'status': TripStatus.TIMEOUT, 'isShow': false},
    {'status': TripStatus.SEARCHING, 'isShow': false},
    {'status': TripStatus.STARTED, 'isShow': false},
    {'status': TripStatus.ARRIVED, 'isShow': false},
    {'status': TripStatus.PICKEDUP, 'isShow': false},
    {'status': TripStatus.DROPPED, 'isShow': false},
    {'status': TripStatus.COMPLETED, 'isShow': false},
  ];

  // turnOnAutoRequestCheck({bool isBooking}) {
  //   this.isStopAutoCheck = false;

  //   if (isBooking == null) {
  //     this.isBooking = false;
  //   } else {
  //     this.isBooking = isBooking;
  //   }

  //   if (_subscription == null) {
  //     _subscription = stream.listen((data) {
  //       changeFlowNotification(data);
  //     });
  //   }
  // }

  // turnOffAutoRequestCheck() {
  //   this.isStopAutoCheck = true;
  //   if (_subscription != null) {
  //     _subscription.cancel();
  //     _subscription = null;
  //   }
  //   _listCheckNotification.forEach((element) {
  //     element['isShow'] = false;
  //   });
  // }

  // Future<void> firstRequestCheck() async {
  //   try {
  //     final response = await dataRepository.getRequestCheck();

  //     String statusCheck = TripStatus.EMPTY;
  //     int idTrip = 0;

  //     if (response.data != null && response.data.length > 0) {
  //       statusCheck = response.data.first?.status ?? TripStatus.EMPTY;
  //       idTrip = response.data.first?.id ?? 0;
  //     }

  //     _tripSubject.add(Trip(
  //         status: statusCheck,
  //         requestCheckResponse: response,
  //         error: null,
  //         id: idTrip));

  //     if (statusCheck != TripStatus.EMPTY) {
  //       if (isStopAutoCheck) {
  //         turnOnAutoRequestCheck();
  //         autoRequestCheck();
  //       }
  //     }
  //   } catch (e) {
  //     _tripSubject.add(Trip(
  //         status: TripStatus.ERROR,
  //         requestCheckResponse: getRequestCheckResponse,
  //         error: e,
  //         id: 0));
  //   }
  // }

  // autoRequestCheck() async {
  //   ///todo turn onAutoRequestCheck is begin autoRequestCheck
  //   if (this.isStopAutoCheck) {
  //     return;
  //   }
  //   await fetchRequestCheck();
  //   await Future.delayed(Duration(seconds: 2));
  //   autoRequestCheck();
  // }

  void registerTripService(int userId) {
    logger.d('startService with userId: $userId');
    DatabaseReference _tripRef = FirebaseDatabase.instance
        .reference()
        .child('/trip/user/$userId/trip_details');
    _tripSubscription = _tripRef.onValue.listen((event) {
      final data = event.snapshot.value;
      print(data);
      fetchRequestCheck();
    });
    fetchRequestCheck();
  }

  void startService(int userId) {
    registerTripService(userId);
    _getTripLocked = false;
    fetchRequestCheck();
  }

  void stopService() {
    _getTripLocked = true;
    _tripSubscription?.cancel();
  }

  void fetchRequestCheck() async {
    try {
      if (_getTripLocked) {
        return;
      }
      _getTripLocked = true;
      final response = await dataRepository.getRequestCheck();
      final currentStatus = getStatus;
      String statusCheck = TripStatus.EMPTY;
      if (response.data != null && response.data.length > 0) {
        statusCheck = response.data.first?.status ?? TripStatus.EMPTY;
      }

      final result = handleTimeOut(currentStatus, statusCheck);
      if (result != null) {
        statusCheck = result;
      }
      final _trip = Trip(
          status: statusCheck, requestCheckResponse: response, error: null);
      _tripSubject.add(_trip);
      changeFlowNotification(_trip);
    } catch (e) {
      _tripSubject.add(Trip(
          status: TripStatus.ERROR,
          requestCheckResponse: getRequestCheckResponse,
          error: e));
    }
    _getTripLocked = false;
  }

  changeStatus(String status) {
    _tripSubject.add(Trip(
        status: status,
        requestCheckResponse: getRequestCheckResponse,
        error: null));
  }

  changeFlowNotification(Trip data) {
    final indexCheck = _listCheckNotification
        .indexWhere((element) => element['status'] == data.status);

    if (_listCheckNotification[indexCheck]['isShow']) {
      return;
    }

    if (this.isBooking) {
      return;
    }

    String key = "";
    switch (data.status) {
      case TripStatus.SEARCHING:
        key = "looking_for_a_provider";
        break;
      case TripStatus.STARTED:
        key = "provier_accepted_your_request";
        break;
      case TripStatus.ARRIVED:
        key = "partner_has_arrived_at_your_location";
        break;
      case TripStatus.PICKEDUP:
        key = "service_is_live";
        break;
      case TripStatus.DROPPED:
        key = "service_is_dropped";
        break;
      case TripStatus.COMPLETED:
        key = "completed_service_please_check_out";
        break;
      case TripStatus.TIMEOUT:
        key = "provider_cancel_request_please_try_again";
        break;
      default:
        key = "";
        break;
    }

    /// notification
    switch (data.status) {
      case 'TIMEOUT':
        print("changeFlow ${data.status}");
        if (data.status == _listCheckNotification[indexCheck]['status']) {
          _snackbarService.showSnackbar(
              message: key.tr,
              duration: Duration(milliseconds: 4000),
              onTap: (_) {
                handleNavigation();
              });
          _listCheckNotification[indexCheck]['isShow'] = true;
        }
        break;
      case 'EMPTY':
        print("changeFlow ${data.status}");
        break;
      case 'SEARCHING':
        print("changeFlow ${data.status}");
        if (data.status == _listCheckNotification[indexCheck]['status']) {
          _snackbarService.showSnackbar(
              message: key.tr,
              duration: Duration(milliseconds: 4000),
              onTap: (_) {
                handleNavigation();
              });
          _listCheckNotification[indexCheck]['isShow'] = true;
        }
        break;
      case 'ACCEPTED':
        print("changeFlow ${data.status}");
        break;
      case 'STARTED':
        print("changeFlow ${data.status}");
        if (data.status == _listCheckNotification[indexCheck]['status']) {
          _snackbarService.showSnackbar(
              message: key.tr,
              duration: Duration(milliseconds: 4000),
              onTap: (_) {
                handleNavigation();
              });
          _listCheckNotification[indexCheck]['isShow'] = true;
        }
        break;
      case 'ARRIVED':
        print("changeFlow ${data.status}");
        if (data.status == _listCheckNotification[indexCheck]['status']) {
          _snackbarService.showSnackbar(
              message: key.tr,
              duration: Duration(milliseconds: 4000),
              onTap: (_) {
                handleNavigation();
              });
          _listCheckNotification[indexCheck]['isShow'] = true;
        }
        break;
      case 'PICKEDUP':
        print("changeFlow ${data.status}");
        if (data.status == _listCheckNotification[indexCheck]['status']) {
          _snackbarService.showSnackbar(
              message: key.tr,
              duration: Duration(milliseconds: 4000),
              onTap: (_) {
                handleNavigation();
              });
          _listCheckNotification[indexCheck]['isShow'] = true;
        }
        break;
      case 'DROPPED':
        print("changeFlow ${data.status}");
        if (data.status == _listCheckNotification[indexCheck]['status']) {
          _snackbarService.showSnackbar(
              message: key.tr,
              duration: Duration(milliseconds: 4000),
              onTap: (_) {
                handleNavigation();
              });
          _listCheckNotification[indexCheck]['isShow'] = true;
        }
        break;
      case 'COMPLETED':
        print("changeFlow ${data.status}");
        if (data.status == _listCheckNotification[indexCheck]['status']) {
          _snackbarService.showSnackbar(
              message: key.tr,
              duration: Duration(milliseconds: 4000),
              onTap: (_) {
                handleNavigation();
              });
          _listCheckNotification[indexCheck]['isShow'] = true;
        }
        break;
      case 'PATCH':
        print("changeFlow ${data.status}");
        break;
      case 'CANCELLED':
        print("changeFlow ${data.status}");
        break;
      case 'SCHEDULED':
        print("changeFlow ${data.status}");
        break;
      default:
        break;
    }
  }

  void handleNavigation() {
    _locatorNavigation.navigateTo(AppRoute.repairService, arguments: {
      'idService': getRequestCheckResponse.data.first.serviceType.parentId,
      'navigationBooking': true
    });
  }

  handleTimeOut(String currentStatus, String statusCheck) {
    String status;
    if (statusCheck == TripStatus.EMPTY) {
      if (currentStatus == TripStatus.SEARCHING ||
          currentStatus == TripStatus.STARTED ||
          currentStatus == TripStatus.ARRIVED) {
        status = TripStatus.TIMEOUT;
      }
    }

    return status ?? null;
  }
}

class Trip {
  RequestCheckResponse requestCheckResponse;
  String status;
  dynamic error;
  int id;

  Trip({this.requestCheckResponse, this.status, this.error, this.id});
}
