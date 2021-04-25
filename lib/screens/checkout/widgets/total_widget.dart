import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/services/widgets/button_process_widget.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    Key key,
    /*  @required this.item,
    @required this.state,*/
    this.onPress,
    this.nameButton,
  }) : super(key: key);

  /*final ServiceModal item;
  final state;*/
  final Function onPress;
  final String nameButton;

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
                'Total',
                style:
                    body1.copyWith(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              Text(
                //'kCurrency${(int.parse(item.money) * state.amount)}',
                "10",
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
