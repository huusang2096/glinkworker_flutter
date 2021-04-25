import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/order_history_cubit.dart';
import 'package:flutter_map_booking/screens/order_history/widgets/ongoing_widget.dart';
import 'package:simplest/simplest.dart';

import 'widgets/order_history_past_widget.dart';
import 'widgets/order_history_schedule_widget.dart';

class OrderHistoryScreen
    extends CubitWidget<OrderHistoryCubit, OrderHistoryState> {
  @override
  void afterFirstLayout(BuildContext context) {
    bloc.loadUserRequestHistory();
  }

  @override
  dispose() {}

  @override
  Widget builder(BuildContext context, OrderHistoryState state) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: false,
          leading: null,
          elevation: 0,
          title: Text(
            'order_history'.tr,
            style: heading1,
          ),
          backgroundColor: whiteColor,
          bottom: PreferredSize(
              preferredSize: Size(700, 80),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Color(0XFFf5f5f5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: TabBar(
                      isScrollable: false,
                      indicatorColor: Colors.transparent,
                      indicator: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: whiteColor),
                      indicatorWeight: 0.0,
                      unselectedLabelColor: blackColor,
                      labelColor: blackColor,
                      labelStyle: textStyleWhite,
                      unselectedLabelStyle: textStyleWhite,
                      tabs: <Widget>[
                        Tab(
                          child: Text(
                            'ongoing'.tr,
                            style: body1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'schedule'.tr,
                            style: body1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'past'.tr,
                            style: body1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
        body: TabBarView(
          children: [
            HisoryOngoingWidget(),
            HisoryScheduleWidget(),
            HisoryPastWidget(),
          ],
        ),
      ),
    );
  }

  @override
  void listener(BuildContext context, OrderHistoryState state) {
    super.listener(context, state);
    if (state is CancelRequestState) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('message'.tr),
          content: Text(state.message.tr),
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                bloc.loadUserRequestHistory();
              },
              child: new Text('ok'.tr),
            ),
          ],
        ),
      );
    }
  }
}
