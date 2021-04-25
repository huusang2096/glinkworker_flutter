import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/home/widgets/custom_clipper_home.dart';

class CardSideWidget extends StatelessWidget {
  const CardSideWidget({
    Key key,
    this.urlImg,
    this.title,
    this.subTitle,
    this.height,
  }) : super(key: key);

  final String urlImg;
  final String title;
  final String subTitle;
  final double height;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          color: Color(0xffFEF2F1),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      width: size.width * 0.85,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
            clipper: CustomClipperHome(),
            child: Container(
              width: size.width * 0.5,
              height: height,
              child: CachedNetworkImage(
                imageUrl: urlImg,
                memCacheWidth: 500,
                fit: BoxFit.cover,
                placeholder: (context, string) {
                  return Container(
                    child: Center(
                        child: CircularProgressIndicator()
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            width: size.width * 0.35,
            height: height,
            padding: EdgeInsets.only(top: 15.0, right: 15.0),
            child: Column(
              children: [
                Flexible(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    style: heading1.copyWith(
                        fontSize: 20.0, color: Color(0xffF34E3F)),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Flexible(
                    child: Text(subTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        style: body1.copyWith()))
              ],
            ),
          )
        ],
      ),
    );
  }
}

List<Map> listSideWidget = [
  {
    "title": 'Clean you home',
    "subTitle": 'you want to use?',
    "urlImg":
    'https://www.afrdynamics.com/wp-content/uploads/2019/04/avarage-ac-repair-cost.jpg'
  },
  {
    "title": 'Clean you home',
    "subTitle": 'you want to use?',
    "urlImg":
    'https://i.pinimg.com/originals/54/e5/64/54e564e596ba02f9482baa74eeb72bf7.jpg'
  },
  {
    "title": 'Clean you home',
    "subTitle": 'you want to use?',
    "urlImg":
    'https://5.imimg.com/data5/IA/EI/TK/SELLER-34021272/ac-repair-centre-ac-service-centre-mumbai-500x500.jpg'
  }
];
