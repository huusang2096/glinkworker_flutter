import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';

class OptionsWidget extends StatelessWidget {
  final double defaultPadding;
  final double height;
  final Color color;
  final IconData icon;
  final String text;
  final Function onPress;

  const OptionsWidget(
      {Key key,
      this.defaultPadding,
      this.height,
      this.color,
      this.icon,
      this.text,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: defaultPadding),
      child: Column(
        children: [
          Container(
            width: height,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(width: 1, color: color.withOpacity(0.35)),
            ),
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(height)),
                  onTap: onPress,
                  child: Container(
                    width: height - 5,
                    height: height - 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: color.withOpacity(0.35)),
                    child: Center(
                      child: Icon(
                        icon,
                        color: color,
                        size: 26.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: defaultPadding / 5,
          ),
          Text(text, style: body1)
        ],
      ),
    );
  }
}

List<Map> fakeDataOption = [
  {'icon': Icons.clear, 'text': 'Cleaning', 'color': Colors.blueAccent},
  {'icon': Icons.reply_all, 'text': 'Repair', 'color': Colors.indigo},
  {'icon': Icons.reply_all, 'text': 'Shifting', 'color': Colors.redAccent},
  {'icon': Icons.reply_all, 'text': 'Car Rental', 'color': Colors.orange},
  {'icon': Icons.clear, 'text': 'Cleaning', 'color': Colors.blueAccent},
  {'icon': Icons.reply_all, 'text': 'Repair', 'color': Colors.indigo},
  {'icon': Icons.reply_all, 'text': 'Shifting', 'color': Colors.redAccent},
  {'icon': Icons.reply_all, 'text': 'Car Rental', 'color': Colors.orange},
];
