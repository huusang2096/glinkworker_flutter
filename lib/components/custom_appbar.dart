import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class CustomAppBar extends StatelessWidget {
  final String text;

  const CustomAppBar({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        text,
        style: heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
      ),
      automaticallyImplyLeading: false,
    );
  }
}
