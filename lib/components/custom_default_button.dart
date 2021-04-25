import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class CustomDefaultButton extends StatelessWidget {
  final String text;
  final Function press;

  const CustomDefaultButton({Key key, this.text, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: FlatButton(
        color: Colors.deepOrange,
        onPressed: press,
        child: Text(
          text,
          style: button,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
