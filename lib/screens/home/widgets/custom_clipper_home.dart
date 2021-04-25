import 'package:flutter/material.dart';

class CustomClipperHome extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.11);
    path.cubicTo(
        0, size.height * 0.05, size.width * 0.03, 0, size.width * 0.07, 0);
    path.cubicTo(
        size.width * 0.07, 0, size.width * 0.89, 0, size.width * 0.89, 0);
    path.cubicTo(size.width * 0.97, 0, size.width * 1.02, size.height * 0.11,
        size.width, size.height / 5);
    path.cubicTo(size.width, size.height / 5, size.width * 0.82,
        size.height * 0.93, size.width * 0.82, size.height * 0.93);
    path.cubicTo(size.width * 0.81, size.height * 0.97, size.width * 0.79,
        size.height, size.width * 0.75, size.height);
    path.cubicTo(size.width * 0.75, size.height, size.width * 0.07, size.height,
        size.width * 0.07, size.height);
    path.cubicTo(size.width * 0.03, size.height, 0, size.height * 0.95, 0,
        size.height * 0.89);
    path.cubicTo(
        0, size.height * 0.89, 0, size.height * 0.11, 0, size.height * 0.11);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
