import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RateStar extends StatelessWidget {
  final Function onPressTip;
  final String textTip;
  final Color iconColor;
  final IconData icons;

  const RateStar({
    Key key,
    this.onPressTip,
    this.textTip,
    this.iconColor,
    this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressTip,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.center,
        width: 70,
        height: 50,
        child: FaIcon(
          icons,
          color: iconColor,
          size: 50,
        ),
      ),
    );
  }
}
