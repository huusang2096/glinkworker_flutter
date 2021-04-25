import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class AppbarWidget extends StatelessWidget {
  final String text;
  final Function callBack;

  const AppbarWidget({
    Key key,
    this.text,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(
          Icons.arrow_back,
          color: blackColor,
        ),
        onPressed: () {
          if (callBack != null) {
            callBack();
          }
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        text,
        style: heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
