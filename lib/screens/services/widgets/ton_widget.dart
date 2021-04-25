import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class TonWidget extends StatelessWidget {
  final Function onPressTon;
  final String textTon;
  final Color colorBackground;
  final Color colorText;
  const TonWidget({
    Key key,
    this.onPressTon,
    this.textTon,
    this.colorBackground, this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressTon,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1000),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
        decoration: BoxDecoration(
            color: colorBackground,
            border: Border.all(color: Color(0xff707070), width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: Center(
            child: Text(
          textTon,
          style: body1.copyWith(fontSize: 14.0, fontWeight: FontWeight.w400,color: colorText),
        )),
      ),
    );
  }
}
