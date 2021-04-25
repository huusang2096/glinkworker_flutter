import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_request_history_response_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simplest/simplest.dart';

class PastCardItemWidget extends StatelessWidget {
  final UserRequestHistoryResponse item;
  Color statusColor;
  DateFormat format = DateFormat("yyyy-MM-dd");
  PastCardItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    if (item.status == "COMPLETED") {
      statusColor = Colors.black45;
    } else {
      statusColor = Colors.red;
    }
    return IntrinsicHeight(
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.maxFinite,
          child: Container(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.serviceType.name.toString() ?? "",
                        style: heading1.copyWith(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            (item.status.toString().toLowerCase()).tr ?? "",
                            style: body1.copyWith(color: whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                  child: Text(
                    item.serviceType.description ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textGreyBold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        AppRoute.pastTripHistoryDetailScreen,
                        arguments: {'requestId': item.id});
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                    child: Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(item.serviceType.image ?? "")),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.serviceType.providerName ?? "",
                                  style: body2.copyWith(fontSize: 18),
                                ),
                              ),
                              RatingBar.builder(
                                onRatingUpdate: null,
                                initialRating: (item.userRated.toDouble()),
                                itemCount: 5,
                                itemSize: 15,
                                allowHalfRating: true,
                                itemBuilder: (context, index) {
                                  return Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.finishedAt == null
                                ? "-"
                                : format.format(item.finishedAt).toString(),
                            textAlign: TextAlign.right,
                            style: body1.copyWith(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text(
                      "book_again".tr,
                      style: body1.copyWith(color: redColor2),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoute.bookingScreen,
                          arguments: {'service': item.serviceType});
                    },
                    color: Color(0XFFfef2f1),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: greyColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}
