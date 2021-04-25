import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RateStarModel {
  final int value;
  final IconData iconUrl;

  RateStarModel(this.value, this.iconUrl);
}

List<RateStarModel> rateStars = [
  RateStarModel(1, FontAwesomeIcons.frownOpen),
  RateStarModel(2, FontAwesomeIcons.angry),
  RateStarModel(3, FontAwesomeIcons.meh),
  RateStarModel(4, FontAwesomeIcons.smile),
  RateStarModel(5, FontAwesomeIcons.laugh)
];
