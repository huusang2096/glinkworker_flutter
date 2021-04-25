import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/resources.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/complete_task_cubit.dart';
import 'package:flutter_map_booking/screens/order_history/widgets/rate_now_modal_widget.dart';
import 'package:simplest/simplest.dart';

class CompletedTaskScreen
    extends CubitWidget<CompleteTaskCubit, CompleteTaskState> {
  CompleteTaskCubit cubit;

  static provider() {
    return BlocProvider(
      create: (context) => CompleteTaskCubit(),
      child: CompletedTaskScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  Widget builder(BuildContext context, CompleteTaskState state) {
    return Scaffold(
      bottomNavigationBar: _bottomButton(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          child: Column(
            children: [
              _buildHeader(context),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.grey,
                height: 1,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 30,
              ),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Image.asset(Images.celebration_icon),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'your_job_is_done'.tr,
            style: heading1,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width * 0.75,
          alignment: Alignment.center,
          child: Text(
            "Great news! The following jobs are done. Please rate the service and let us know there is anything that can be improve.",
            textAlign: TextAlign.center,
            style: body1.copyWith(color: Colors.grey),
          ),
        )
      ],
    );
  }

  _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
                padding: EdgeInsets.only(left: 20),
                height: 70,
                width: 70,
                child: Image.asset(
                  Images.air_condition_icon,
                  color: redColor2,
                )),
            Container(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Column(
                children: [
                  Text(
                    "AC Servicing",
                    style: heading1.copyWith(fontSize: 20),
                  ),
                  Text(
                    "Job ID: 213123",
                    style: body1.copyWith(color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.date_range_outlined),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "19 March 2020, 10:24am- 11:58pm",
                style: body1,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.map_outlined),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "116 Doyle Fall Apt. 105",
                style: body1,
              ),
            ),
          ],
        )
      ],
    );
  }

  _buildBottomSheet(BuildContext context) {
    final cubit = context.bloc<CompleteTaskCubit>();
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: RateNowModalWidget(),
        );
      },
    );
  }

  _bottomButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: InkWell(
          onTap: () {
            _buildBottomSheet(context);
          },
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: redColor2, borderRadius: BorderRadius.circular(15)),
            child: Text(
              "rate_now".tr,
              style: heading18,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
