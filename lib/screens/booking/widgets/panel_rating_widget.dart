import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart' as style;
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';
import 'package:flutter_map_booking/screens/booking/widgets/content_in_sliding_up_panel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simplest/simplest.dart';

class PanelRatingWidget extends StatelessWidget {
  final Size size;
  final String title;
  final String urlImg;
  final int rating;
  final Function(int) ratingCallBack;
  final Function(String) commentCallBack;
  final Function() onPressSubmit;
  final TextEditingController controller;

  PanelRatingWidget(
      {Key key,
      @required this.size,
      @required this.title,
      @required this.urlImg,
      @required this.ratingCallBack,
      @required this.commentCallBack,
      @required this.onPressSubmit,
      @required this.controller,
      @required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: double.infinity,
        child: Column(
          // shrinkWrap: true,

          // physics: AlwaysScrollableScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: style.title.copyWith(fontSize: 18.0)),
            ),
            Container(
              height: 80.0,
              child: Center(
                child: CachedNetworkImage(
                  memCacheWidth: 600,
                  imageUrl: urlImg,
                  imageBuilder: (context, img) {
                    return Container(
                      width: 120.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:
                              DecorationImage(image: img, fit: BoxFit.cover)),
                    );
                  },
                  placeholder: (context, string) {
                    return Container(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorWidget: (context, string, dynamic) {
                    return Container(
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              width: size.width,
              child: Center(
                child: RatingBar.builder(
                  initialRating: 5.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ratingCallBack(rating.toInt());
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: size.width,
              child: TextField(
                controller: controller,
                maxLines: null,
                onChanged: (value) {
                  commentCallBack(value);
                },
                decoration: InputDecoration(
                  hintText: 'write_your_comment'.tr,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            buildButtonDoneInvoice(
                text: 'submit'.tr,
                onPress: () {
                  onPressSubmit();
                }),
            SizedBox(
              height: 16.0,
            )
          ],
        ),
      ),
    );
  }
}
