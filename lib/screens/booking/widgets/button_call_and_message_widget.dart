import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class ButtonCallAndMessageWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPress;

  const ButtonCallAndMessageWidget({
    Key key,
    this.text,
    this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(

        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xfffef2f1)),
              child: Center(
                child: Icon(
                  icon,
                  color: Color(0xfff34e3f),
                ),
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              text,
              style: body2.copyWith(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
