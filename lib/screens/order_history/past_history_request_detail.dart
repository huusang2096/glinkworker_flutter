import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/resources.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/past_trip_cubit.dart';
import 'package:flutter_map_booking/screens/order_history/models/report_item_request_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:simplest/simplest.dart';

import 'models/user_dispute_request_model.dart';

class PastHistoryRequestDetailScreen
    extends CubitWidget<PastTripCubit, PastTripState> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final int requestId;
  TextEditingController txtController = new TextEditingController();
  DateFormat dateFormat = DateFormat("MM-dd-yyyy");
  DateFormat timeFormat = DateFormat('hh:mm:ss');

  PastHistoryRequestDetailScreen(this.requestId);

  static provider(int request_id) {
    return BlocProvider<PastTripCubit>(
      create: (_) => PastTripCubit(),
      child: PastHistoryRequestDetailScreen(request_id),
    );
  }

  @override
  void listener(BuildContext context, PastTripState state) {
    super.listener(context, state);
    if (state is DisputeSuccess) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          onVisible: () {
            bloc.getPastTripDetail(requestId);
          },
          duration: const Duration(seconds: 3),
          content: new Text(state.message)));
    }
    if (state is ReportLostItem) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          onVisible: () {
            bloc.getPastTripDetail(requestId);
          },
          duration: const Duration(seconds: 3),
          content: new Text(state.message)));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getPastTripDetail(requestId);
  }

  @override
  Widget builder(BuildContext context, PastTripState state) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          actions: [_buildActionDisputeButton(context)],
          backgroundColor: Colors.white,
          leading: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'past_request_detail'.tr,
            style:
                heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
        body: _buildBody(context, state));
  }

  _buildBody(BuildContext context, PastTripState state) {
    bool isEmpty = (state.pastTripDetail ?? []).isEmpty;

    if (state.isLoading) {
      return Center(
          child: SpinKitCircle(
        color: primaryColor,
      ));
    }
    if (isEmpty) {
      return Center(
        child: Text(
          'empty'.tr,
          style: body1,
        ),
      );
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 70,
                    width: 70,
                    child: bloc.state.pastTripDetail[0].provider.avatar == null
                        ? CircleAvatar(child: Image.asset(Images.defaultAvatar))
                        : CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: BASE_URL_STORAGE +
                                  bloc.state.pastTripDetail[0].provider.avatar,
                              width: 72.0,
                              height: 72.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${bloc.state.pastTripDetail[0].provider.firstName} ${bloc.state.pastTripDetail[0].provider.lastName}",
                          style: body1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      RatingBar.builder(
                        onRatingUpdate: null,
                        initialRating: (5.0),
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
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          dateFormat
                              .format(bloc.state.pastTripDetail[0].startedAt),
                          style: body1,
                        ),
                        SizedBox(height: 10),
                        Text(
                            timeFormat
                                .format(bloc.state.pastTripDetail[0].startedAt),
                            style: body1),
                        SizedBox(height: 10),
                        Text(bloc.state.pastTripDetail[0].bookingId,
                            style: body1)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              height: 5,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    FontAwesomeIcons.gripLinesVertical,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      bloc.state.pastTripDetail[0].sAddress,
                      style: body1,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 5,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Text(
                "pay_via".tr,
                style: body1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(FontAwesomeIcons.moneyBill),
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            bloc.state.pastTripDetail[0]?.paymentMode ?? "-")),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      "${bloc.state.pastTripDetail[0].payment?.cash ?? "-"}" +
                          kCurrency),
                )
              ],
            ),
            Divider(
              thickness: 2,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "comment".tr,
                  style: body1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: Text(
                    bloc.state.pastTripDetail[0].rating.providerComment == null
                        ? "no_comment".tr
                        : bloc.state.pastTripDetail[0].rating.providerComment),
              ),
            ),
            _buildViewReceiptButton(context),
          ],
        ),
      ),
    );
  }

  _buildViewReceiptButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => _buildViewReceipt(context));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              color: redColor2, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "view_receipt".tr.toUpperCase(),
            style: body1.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _buildDisputeBottomSheet(
    BuildContext context,
  ) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        if (bloc.state.disputeList == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          padding: EdgeInsets.all(10),
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "dispute".tr,
                  style: heading1,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        bloc.selectedDispute(index);
                        setState(() {
                          bloc.state.selectedDispute = index;
                        });
                      },
                      title: Text(bloc.state.disputeList[index].disputeName),
                      leading: bloc.state.selectedDispute == index
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.check_circle,
                              color: Colors.grey,
                            ),
                    );
                  },
                  itemCount: bloc.state.disputeList.length,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        bloc.state.selectedDispute = null;
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: redColor2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "dismiss".tr,
                          style: body1.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (bloc.state.selectedDispute == null) {
                          return;
                        } else {
                          DisputeRequest request = new DisputeRequest();
                          request.disputeName = bloc
                              .state
                              .disputeList[bloc.state.selectedDispute]
                              .disputeName;
                          request.providerId =
                              bloc.state.pastTripDetail[0].providerId;
                          request.userId = bloc.state.pastTripDetail[0].userId;
                          request.requestId = bloc.state.pastTripDetail[0].id;
                          request.disputeType = "user";
                          request.comments =
                              bloc.state.pastTripDetail[0].rating.userComment;
                          bloc.dispute(request);
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: redColor2,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("submit".tr,
                            style: body1.copyWith(color: Colors.white)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildActionDisputeButton(BuildContext context) {
    if (bloc.state.pastTripDetail == null) {
      return SizedBox.shrink();
    } else if (bloc.state.pastTripDetail[0].isDispute == 0) {
      print("Status:  1");
      return _buildDisputePopupMenu(context);
    } else if (bloc.state.pastTripDetail[0].isDispute == 1) {
      return _buildDisputeStatusPopupMenu(context);
    }
  }

  _buildDisputeStatusBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "dispute".tr,
              style: heading1,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "this_trip_was_dispute_to_admin".tr,
              style: body1,
            ),
          ],
        ),
      ),
    );
  }

  _buildLostItemStatusBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 300,
      child: Center(
        child: Text(
          "your_report_is_send_to_admin".tr,
          style: body1,
        ),
      ),
    );
  }

  _buildViewReceipt(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "invoice".tr,
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
                    Text(bloc.state.pastTripDetail[0].bookingId, style: body1)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("fixed".tr, style: body1),
                    Text(
                        "${bloc.state.pastTripDetail[0]?.payment?.fixed ?? "-"}" +
                            kCurrency,
                        style: body1)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("discount".tr, style: body1),
                    Text(
                        "${bloc.state.pastTripDetail[0]?.payment?.discount ?? "-"}" +
                            kCurrency,
                        style: body1)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("tax".tr, style: body1),
                    Text(
                        "${bloc.state.pastTripDetail[0]?.payment?.tax ?? "-"}" +
                            kCurrency,
                        style: body1)
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("total".tr,
                        style: body1.copyWith(fontWeight: FontWeight.bold)),
                    Text(
                        "${bloc.state.pastTripDetail[0]?.payment?.cash ?? "-"}" +
                            kCurrency,
                        style: body1.copyWith(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: redColor2,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "close".tr.toUpperCase(),
                      style: body1.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildReportLostItemBottomSheet(context) {
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "lost_item".tr,
              style: heading1,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 4,
              textInputAction: TextInputAction.go,
              controller: txtController,
              decoration: InputDecoration(
                labelText: 'lost_item_name'.tr,
                labelStyle: body1.copyWith(color: Colors.grey.withOpacity(0.5)),
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
                      ReportLostItemRequest request =
                          new ReportLostItemRequest();
                      request.requestId = bloc.state.pastTripDetail[0].id;
                      request.userId = bloc.state.pastTripDetail[0].userId;
                      request.lostItemName = txtController.text.toString();
                      Navigator.of(context).pop();
                      bloc.reportLostItem(request);
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

  _buildDisputeStatusPopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          builder: (context) {
            print("Status:  " + value);
            if (value == "dispute_status".tr) {
              return _buildDisputeStatusBottomSheet(context);
            } else {
              if (bloc.state.pastTripDetail[0].lostitem == null) {
                return _buildReportLostItemBottomSheet(context);
              } else {
                return _buildLostItemStatusBottomSheet(context);
              }
            }
          },
        );
      },
      itemBuilder: (BuildContext context) {
        return {'dispute_status'.tr, 'lost_item'.tr}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: body1,
            ),
          );
        }).toList();
      },
    );
  }

  _buildDisputePopupMenu(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          builder: (context) {
            if (value == "dispute".tr) {
              return _buildDisputeBottomSheet(context);
            } else {
              if (bloc.state.pastTripDetail[0].lostitem == null) {
                return _buildReportLostItemBottomSheet(context);
              } else {
                return _buildLostItemStatusBottomSheet(context);
              }
            }
          },
        );
      },
      itemBuilder: (BuildContext context) {
        return {'dispute'.tr, 'lost_item'.tr}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(
              choice,
              style: body1,
            ),
          );
        }).toList();
      },
    );
  }
}
