import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class TipWidget extends StatelessWidget {
  final Function onPressTip;
  final String textTip;
  final Color colorBackground;
  final Color colorText;

  const TipWidget({
    Key key,
    this.onPressTip,
    this.textTip,
    this.colorBackground,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressTip,
      child: Container(
        width: 70,
        height: 50,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
          decoration: BoxDecoration(
              color: colorBackground,
              border: Border.all(color: Color(0xff707070), width: 0.2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Center(
              child: Text(
                textTip,
                style: body1.copyWith(
                    fontSize: 14.0, fontWeight: FontWeight.w400, color: colorText),
              )),
        ),
      ),
    );
  }
}
