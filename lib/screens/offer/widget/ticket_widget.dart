library flutter_ticket_widget;

import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';

class FlutterTicketWidget extends StatefulWidget {
  final double width;
  final double height;
  final Widget child;
  final Widget header;
  final Color color;
  final bool isCornerRounded;

  FlutterTicketWidget({
    @required this.width,
    @required this.height,
    @required this.child,
    this.color = Colors.white,
    this.isCornerRounded = false,
    this.header,
  });

  @override
  _FlutterTicketWidgetState createState() => _FlutterTicketWidgetState();
}

class _FlutterTicketWidgetState extends State<FlutterTicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
          duration: Duration(seconds: 3),
          width: widget.width,
          height: widget.height,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  color: primaryColor,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_offer_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    widget.header,
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.star_border,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              widget.child,
            ],
          ),
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(10.0))),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 1.45), radius: 10.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 1.45), radius: 10.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
