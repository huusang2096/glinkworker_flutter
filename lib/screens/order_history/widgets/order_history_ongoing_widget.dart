import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/order_history_cubit.dart';
import 'package:simplest/simplest.dart';

import 'ongoing_trip_card_widget.dart';

class HisoryOngoingWidget extends StatelessWidget {
  OrderHistoryCubit _cubit;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    _cubit = context.watch<OrderHistoryCubit>();
    TripService tripService = locator<TripService>();
    RequestCheckResponse ongoingTrip = tripService.getRequestCheckResponse;
    bool isEmpty = (ongoingTrip?.data ?? []).isEmpty;

    void _onRefresh() async {
      if (_refreshController.isRefresh) {
        await _cubit.refreshData();
        _refreshController.refreshCompleted();
      }
    }

    if (_cubit.state.isLoading) {
      return Center(
        child: SpinKitCircle(
          color: primaryColor,
        ),
      );
    }
    Widget contentWidget = SizedBox.shrink();
    if (isEmpty) {
      contentWidget = SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Images.logo.loadImage(height: 72),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "empty".tr,
                    style: body1.copyWith(fontSize: 15),
                  ),
                ],
              ),
            )),
      );
    } else {
      contentWidget = OngoingTripCard(ongoingTrip);
    }
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: _onRefresh,
      header: ClassicHeader(
        completeIcon: Icon(Icons.done, color: primaryColor),
        refreshingIcon: SpinKitCircle(
          size: 25,
          color: primaryColor,
        ),
        releaseIcon: Icon(Icons.refresh, color: primaryColor),
        refreshingText: '',
        releaseText: '',
        idleText: '',
        completeText: '',
      ),
      child: contentWidget,
    );
  }
}
