import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/notification_response.dart';
import 'package:flutter_map_booking/screens/notification/cubit/notification_cubit.dart';
import 'package:simplest/simplest.dart';

class NotificationScreen
    extends CubitWidget<NotificationCubit, NotificationState> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static provider() {
    return BlocProvider(
      create: (_) => NotificationCubit(),
      child: NotificationScreen(),
    );
  }

  @override
  void listener(BuildContext context, NotificationState state) {
    super.listener(context, state);
    if (state is GetNotificationSuccessState ||
        state is NotificationErrorState) {
      _refreshController.refreshCompleted();
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getNotification();
  }

  @override
  Widget builder(BuildContext context, NotificationState state) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
        leading: null,
        elevation: 0,
        title: Text(
          'notification'.tr,
          style: heading1,
        ),
        backgroundColor: whiteColor,
      ),
      body: _buildBody(context, state),
    );
  }

  _handleRefresh() {
    bloc.getNotification();
  }

  _buildBody(BuildContext context, NotificationState state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: state.notificationResponses != null
          ? Builder(
              builder: (context) {
                return SmartRefresher(
                  controller: _refreshController,
                  header: ClassicHeader(
                    refreshingText: '',
                    releaseText: '',
                    idleText: '',
                    completeText: '',
                  ),
                  enablePullDown: true,
                  onRefresh: _handleRefresh,
                  child: ListView.separated(
                      itemBuilder: (_, index) => _buildNotificationItem(
                          state.notificationResponses[index]),
                      separatorBuilder: (_, index) => Container(
                            height: 16.0,
                          ),
                      itemCount: state.notificationResponses == null
                          ? 0
                          : state.notificationResponses.length),
                );
              },
            )
          : Center(
              child: Text('empty_notifications'.tr),
            ),
    );
  }

  Widget _buildNotificationItem(NotificationResponse notificationModel) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: primaryColor,
              width: 1, //                   <--- border width here
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              notificationModel.image.isNullOrBlank
                  ? Container(
                      width: 60,
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: primaryColor),
                      child: Icon(
                        Icons.notifications,
                        size: 28,
                        color: Colors.white,
                      ),
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                notificationModel.image ?? ""),
                            fit: BoxFit.cover),
                      ),
                    ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(notificationModel.description,
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                    SizedBox(height: 5),
                    Text(
                        notificationModel?.expiryDate == null
                            ? ''
                            : fullDateFormatter.format(
                                DateTime.parse(notificationModel.expiryDate)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                            fontSize: 16.0)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
