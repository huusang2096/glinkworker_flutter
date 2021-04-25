
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class ButtonProcessWidget extends StatelessWidget {
  final Function onPress;
  final String nameButton;
  const ButtonProcessWidget({
    Key key, this.onPress, this.nameButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(15.0))),
      padding: EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 20.0),
      onPressed: onPress,
      color: Color(0xffF34E3F),
      child: Container(
        child: Row(
          children: [
            Text(
              nameButton,
              style: button,
            ),
            SizedBox(
              width: 20.0,
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
