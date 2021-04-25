import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/screens/offer/cubit/offer_cubit.dart';
import 'package:flutter_map_booking/screens/offer/widget/dot_line_dash_widget.dart';
import 'package:flutter_map_booking/screens/offer/widget/ticket_widget.dart';
import 'package:flutter_map_booking/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class OfferScreen extends CubitWidget<OfferCubit, OfferState> {
  final bool disableTap;

  OfferScreen({this.disableTap});

  static provider({BuildContext context, bool disableTap}) {
    return BlocProvider<OfferCubit>(
      create: (context) => OfferCubit(),
      child: OfferScreen(disableTap: disableTap),
    );
  }

  _initUI(BuildContext context) {}

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getOffer();
  }

  @override
  Widget builder(BuildContext context, OfferState state) {
    return Scaffold(
      appBar: AppBar(
        title: Text("offers".tr),
      ),
      body: state.isLoading
          ? Center(
              child: SpinKitCircle(
                color: primaryColor,
              ),
            )
          : SafeArea(child: _buildBody(context, state)),
    );
  }

  Widget _buildBody(BuildContext context, OfferState state) {
    bool isEmpty = (state.response ?? []).isEmpty;
    return isEmpty
        ? Center(
            child: Text(
              'empty_voucher'.tr,
              style: body1,
            ),
          )
        : Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.response.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: FlutterTicketWidget(
                            color: Colors.grey.withOpacity(0.3),
                            width: 350.0,
                            height: 250,
                            header: Expanded(
                              child: Text(
                                "${state.response[index].promoCode}",
                                textAlign: TextAlign.center,
                                style: body1.copyWith(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (!disableTap)
                                  Navigator.of(context)
                                      .pop({'promo': state.response[index]});
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.topCenter,
                                            height: 60,
                                            width: 150,
                                            child: Text(
                                              "${state.response[index].percentage}%",
                                              style: body1.copyWith(
                                                fontSize: 50,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            width: 100,
                                            height: 60,
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.all(5),
                                                labelText: 'max_amount'.tr,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
                                              child: Text(
                                                '${state.response[index].maxAmount}' +
                                                    kCurrency,
                                                textAlign: TextAlign.center,
                                                style: body1.copyWith(
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Text(
                                          "${state.response[index].promoDescription}",
                                          style: body1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      MySeparator(
                                        height: 1,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today_outlined,
                                                  size: 25,
                                                  color: primaryColor,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "expires_date".tr,
                                                      style: body1.copyWith(
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      "${dateFormatter.format(state.response[index].expiration)}",
                                                      style: body1.copyWith(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Icon(Icons.local_offer,
                                                    color: primaryColor,
                                                    size: 25),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "expires_hours".tr,
                                                      style: body1.copyWith(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${hourFormatter.format(state.response[index].expiration)}",
                                                      style: body1.copyWith(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
