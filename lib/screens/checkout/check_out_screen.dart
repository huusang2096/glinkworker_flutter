import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/screens/checkout/cubit/check_out_cubit.dart';
import 'package:flutter_map_booking/screens/checkout/widgets/total_widget.dart';
import 'package:simplest/simplest.dart';

class CheckOutScreen extends StatelessWidget {
  static provider() {
    return BlocProvider(
      create: (context) => CheckOutCubit(),
      child: CheckOutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: TotalWidget(
          /* state: cubit.state,
          item: item,*/
          nameButton: 'checkout'.tr,
          onPress: () {
            print('checkout'.tr);
          },
        ),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: blackColor),
          backgroundColor: whiteColor,
          automaticallyImplyLeading: true,
          title: Text(
            "checkout".tr,
            style: heading1,
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Container(
              color: whiteColor,
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.date_range, size: 30),
                                ),
                              ),
                              TextSpan(
                                text: "schedule".tr,
                                style: body1,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            child: Text(
                              'change'.tr,
                              style: body1.copyWith(color: redColor2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("schedule_date".tr),
                        Text("schedule_time".tr),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "08",
                              style: heading1,
                            ),
                            Text("Mar 2020")
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: greyColor,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "4:00 PM",
                              style: heading1,
                            ),
                            Text("Mar 2020")
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      FontAwesomeIcons.mapMarkedAlt,
                                      size: 30,
                                      color: greyColor,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: "address".tr,
                                  style: body1,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              child: Text(
                                'change'.tr,
                                style: body1.copyWith(color: redColor2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 60),
                      child: Text("116 Doyle Fall Apt.105"),
                    )
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      FontAwesomeIcons.tags,
                                      size: 30,
                                      color: greyColor,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: "promo".tr,
                                  style: body1,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              child: Text(
                                "+" + 'add'.tr,
                                style: body1.copyWith(color: redColor2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: IntrinsicHeight(
              child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 15),
                                      child: Icon(
                                        FontAwesomeIcons.cog,
                                        size: 30,
                                        color: greyColor,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "setting".tr,
                                    style: body1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Container(
                          height: 80,
                          margin:
                              EdgeInsets.only(top: 10.0, left: 20, right: 20),
                          decoration: BoxDecoration(
                              color: Color(0xffF5F5F5),
                              border: Border.all(width: 1, color: greyColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: new ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 250.0, minHeight: 80.0),
                            child: new Scrollbar(
                              child: new SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: new TextField(
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 15.0),
                                      hintText: 'written_here'.tr,
                                      border: InputBorder.none),
                                  maxLines: null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
