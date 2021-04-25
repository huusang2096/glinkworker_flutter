import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/cancel_booking_request.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/order_history_cubit.dart';
import 'package:flutter_map_booking/screens/order_history/models/user_request_upcoming_history_response_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simplest/simplest.dart';

class UpcomingTripCard extends StatelessWidget {
  final UserRequestUpcomingHistoryResponse item;
  OrderHistoryCubit cubit;
  DateFormat format = DateFormat("yyyy-MM-dd");
  TextEditingController txtController = new TextEditingController();

  UpcomingTripCard(this.item, this.cubit);

  _buildSubmitCancel(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "submit_cancel_reason".tr,
              style: heading1,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "booking_id".tr,
                  style: body1,
                ),
                Text(item.bookingId, style: body1)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              textInputAction: TextInputAction.go,
              controller: txtController,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'reason_to_cancel'.tr,
                hintStyle: body1.copyWith(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  child: FlatButton(
                    height: 50,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      CancelBookingRequest request = new CancelBookingRequest();
                      request.requestId = item.id;
                      request.cancelReason = txtController.text;
                      Navigator.of(context).pop();
                      cubit.cancelRequest(request);
                    },
                    child: Text(
                      'submit'.tr,
                      style: body1.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: FlatButton(
                    height: 50,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'close'.tr,
                      style: body1.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.bloc<OrderHistoryCubit>();
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
                            color: Colors.green,
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
                      EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
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
                        AppRoute.upcomingTripHistoryDetailScreen,
                        arguments: {'requestId': item.id});
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 0),
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
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text(
                      "cancel".tr,
                      style: body1.copyWith(color: primaryColor),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => _buildSubmitCancel(context));
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
