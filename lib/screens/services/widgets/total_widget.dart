import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/services/widgets/button_process_widget.dart';
import 'package:simplest/simplest.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    Key key,
    this.onPress,
    this.nameButton,
    this.total,
  }) : super(key: key);

  final Function onPress;
  final String nameButton;
  final total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 70.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'total'.tr,
                style:
                    body1.copyWith(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              Text(
                '$total' + kCurrency,
                style: heading1.copyWith(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          ButtonProcessWidget(
            onPress: onPress,
            nameButton: nameButton,
          )
        ],
      ),
    );
  }
}
