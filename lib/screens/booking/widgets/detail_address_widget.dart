import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';

class DetailAddress extends StatelessWidget {
  const DetailAddress({
    Key key,
    this.isDisable,
    this.size,
    this.onPressLocation,
    this.onPressAddress,
    this.state,
  }) : super(key: key);
  final bool isDisable;
  final Size size;
  final BookingState state;
  final Function onPressLocation;
  final Function onPressAddress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 30.0,
      right: 30.0,
      top: 70.0,
      child: Container(
        padding: EdgeInsets.all(0),
        color: Colors.white,
        width: size.width * 0.8,
        height: size.height * 0.08,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (!isDisable) {
                    onPressLocation();
                  }
                },
                child: Container(
                  child: Icon(
                    Icons.location_on,
                  ),
                  width: 40.0,
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (!isDisable) {
                      onPressAddress();
                    }
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      state.myPlace.name ?? "",
                      style: body1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
