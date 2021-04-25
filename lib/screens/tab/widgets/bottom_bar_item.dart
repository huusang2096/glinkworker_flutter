
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class BottomBarItem extends StatelessWidget {

  final String title;
  final Function onPress;
  final Color color;
  final IconData icon;
  const BottomBarItem({
    Key key, this.title, this.onPress, this.color, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: (){
            onPress();
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon,color: color,
              ),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: body2.copyWith(fontWeight: FontWeight.w400,color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}