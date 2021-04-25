// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_map_booking/common/config.dart';
// import 'package:flutter_map_booking/common/ui_helper.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:rxdart/rxdart.dart';

// class LocationManager  {
//   StreamSubscription<Position> _positionSubscription;
//   BehaviorSubject<Position> positionSubject = BehaviorSubject<Position>();

//   Future<bool> requestPermissionAndService(BuildContext context) async {
//     LocationPermission locationPermission;
//     try {
//       locationPermission = await checkPermission();
//       if (locationPermission == LocationPermission.denied ||
//           locationPermission == LocationPermission.deniedForever) {
//         locationPermission = await requestPermission();
//       }
//     } catch (error) {
//       logger.e(error);
//       return false;
//     }
//     bool isLocationEnabled = await isLocationServiceEnabled();
//     if (!isLocationEnabled) {
//       showPopUp(context, 'please_enable_location', onSelect: () {
//         openLocationSettings();
//       });
//       return false;
//     } else if (locationPermission == LocationPermission.denied ||
//         locationPermission == LocationPermission.deniedForever) {
//       showPopUp(context, 'please_enable_location', onSelect: () {
//         openAppSettings();
//       });
//       return false;
//     } else {
//       final lastKnownPosition = await getLastKnownPosition();
//       positionSubject.add(lastKnownPosition);
//     }

//     if (_positionSubscription == null || _positionSubscription.isPaused) {
//       _positionSubscription = getPositionStream().listen((position) {
//         positionSubject.add(position);
//       });
//     }
//     return true;
//   }

//   distanceBetween(
//       double fromLat, double fromLng, double toLat, double toLng) async {
//     final double distance =
//         await distanceBetween(fromLat, fromLng, toLat, toLng);
//     return distance;
//   }

//   close() {
//     _positionSubscription.cancel();
//     positionSubject.close();
//   }
// }
