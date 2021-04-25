import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/upcoming_trip_cubit.dart';
import 'package:simplest/simplest.dart';

class UpcomingHistoryRequestDetailScreen
    extends CubitWidget<UpcomingTripCubit, UpcomingTripState> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final int requestId;
  DateFormat dateFormat = DateFormat("MM-dd-yyyy");
  DateFormat timeFormat = DateFormat('hh:mm:ss');
  TextEditingController txtController = new TextEditingController();
  UpcomingHistoryRequestDetailScreen(this.requestId);

  static provider(int request_id) {
    return BlocProvider<UpcomingTripCubit>(
      create: (_) => UpcomingTripCubit(),
      child: UpcomingHistoryRequestDetailScreen(request_id),
    );
  }

  @override
  void listener(BuildContext context, UpcomingTripState state) {
    super.listener(context, state);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getUpcomingTripDetail(requestId);
  }

  @override
  Widget builder(BuildContext context, UpcomingTripState state) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
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
            'upcoming_request_detail'.tr,
            style:
                heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
        ),
        body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    if (bloc.state.upcomingTripDetail == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
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
                      child: CircleAvatar(
                        child: CachedNetworkImage(
                          imageUrl: bloc
                              .state.upcomingTripDetail[0].serviceType.image,
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
                            "${bloc.state.upcomingTripDetail[0].serviceType.providerName ?? ""}",
                            style: body1,
                            textAlign: TextAlign.left,
                          ),
                        ),
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
                            dateFormat.format(
                                bloc.state.upcomingTripDetail[0].createdAt),
                            style: body1,
                          ),
                          SizedBox(height: 10),
                          Text(
                              timeFormat.format(
                                  bloc.state.upcomingTripDetail[0].createdAt),
                              style: body1),
                          SizedBox(height: 10),
                          Text(bloc.state.upcomingTripDetail[0].bookingId,
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
                        bloc.state.upcomingTripDetail[0].sAddress,
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
                              bloc.state.upcomingTripDetail[0]?.paymentMode ??
                                  "-")),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
