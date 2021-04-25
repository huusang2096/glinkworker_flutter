import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';
import 'package:simplest/simplest.dart';

class ActionHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tripService = locator<TripService>();
    if (tripService.currentTrip == null ||
        tripService.currentTrip.status == TripStatus.COMPLETED ||
        tripService.currentTrip.status == TripStatus.SEARCHING ||
        context.watch<BookingCubit>().state.statusCheck == TripStatus.EMPTY) {
      return SizedBox.shrink();
    }

    return Container(
      height: 76,
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => context.read<BookingCubit>().onSelectSOS(),
            child: Container(
              width: 60,
              height: 60,
              alignment: Alignment.center,
              child: Text(
                "SOS",
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                  color: redColor2, borderRadius: BorderRadius.circular(60)),
            ),
          ),
          InkWell(
            onTap: () => context.read<BookingCubit>().onSelectCalling(),
            child: Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  color: redColor2, borderRadius: BorderRadius.circular(40)),
            ),
          ),
          InkWell(
            onTap: () => context.read<BookingCubit>().onSelectChat(),
            child: Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  color: redColor2, borderRadius: BorderRadius.circular(40)),
            ),
          ),
        ],
      ),
    );
  }
}
