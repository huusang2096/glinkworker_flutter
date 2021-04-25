import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simplest/simplest.dart';

class OngoingTripCard extends StatelessWidget {
  RequestCheckResponse item;
  DateFormat format = DateFormat("yyyy-MM-dd");
  TextEditingController txtController = new TextEditingController();
  OngoingTripCard(this.item);

  @override
  Widget build(BuildContext context) {
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
                        item.data.first?.serviceType?.name?.toString() ?? "",
                        style: heading1.copyWith(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            (item.data.first?.status.toString().toLowerCase())
                                    .tr ??
                                "",
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
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
                  child: Text(
                    item.data.first?.serviceType?.description ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textGreyBold,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.bookingScreen,
                          arguments: {'service': item.data.first.serviceType});
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 5, left: 10, right: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    item.data.first?.serviceType?.image ?? "")),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5, left: 10, right: 10, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item.data.first?.serviceType
                                            ?.providerName ??
                                        "",
                                    style: body2.copyWith(fontSize: 18),
                                  ),
                                ),
                                RatingBar.builder(
                                  onRatingUpdate: null,
                                  initialRating:
                                      (item.data.first?.userRated?.toDouble()),
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
                              item.data.first.createdAt == null
                                  ? "-"
                                  : format
                                      .format(item.data.first.createdAt)
                                      .toString(),
                              textAlign: TextAlign.right,
                              style: body1.copyWith(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: greyColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}
