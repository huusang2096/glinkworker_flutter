import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/locator.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/screens/booking/widgets/panel_rating_widget.dart';
import 'package:flutter_map_booking/services/trip_service.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';
import 'package:flutter_map_booking/screens/booking/widgets/actions_header_widget.dart';
import 'package:flutter_map_booking/screens/booking/widgets/content_in_sliding_up_panel.dart';
import 'package:flutter_map_booking/screens/booking/widgets/panel_status_cancel.dart';
import 'package:simplest/simplest.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpPanelWidget extends CubitWidget<BookingCubit, BookingState> {
  final ServicesResponse service;
  final PanelController panelController;

  SlidingUpPanelWidget({this.service, this.panelController});

  Future<void> _launched;
  final List<String> listItemPayment = ['cash'];
  final locatorSnackBar = locator<SnackbarService>();

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void listener(BuildContext context, BookingState state) {
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, BookingState state) {
    Size size = MediaQuery.of(context).size;
    return SlidingUpPanel(
      color: Colors.transparent,
      boxShadow: [],
      renderPanelSheet: true,
      controller: panelController,
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActionHeaderWidget(),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      )),
                  child: buildPanel(context, size, state))),
        ],
      ),
      // collapsed: buildCollapsed(context),
      defaultPanelState: PanelState.OPEN,
      parallaxEnabled: true,
      parallaxOffset: .8,
      maxHeight: bloc.handleMaxHeight(size, state.statusCheck),
      minHeight: size.height * 0.2,
    );
  }

  Widget buildPanel(BuildContext context, Size size, BookingState state) {
    final status = bloc.state.statusCheck;

    if (state.statusCheck == TripStatus.EMPTY ||
        bloc.state.requestCheckResponse.data.isNullOrBlank) {
      return panelDefaultContent(context, size);
    }

    final _currentTrip = bloc.state.requestCheckResponse.data.first;

    if (state.statusCheck == TripStatus.SEARCHING) {
      return buildSearchingPanelContent(
          state: state,
          text: 'searching'.tr,
          onPress: () {
            state.isDisableDetailAddress = true;
            bloc.submitReasonCancel();
            // bloc.changeStatusCheck(status: TripStatus.CANCEL);
          });
    }

    if (state.statusCheck == TripStatus.CANCEL) {
      return PanelStatusCancel();
    }

    if (state.statusCheck == TripStatus.STARTED ||
        state.statusCheck == TripStatus.ARRIVED ||
        state.statusCheck == TripStatus.PICKEDUP) {
      final provider = bloc.state.requestCheckResponse.data.first?.provider;
      final common = bloc.state.requestCheckResponse.data.first;
      return panelStatusStarted(
          onPressCancel: () {
            bloc.changeStatusCheck(status: TripStatus.CANCEL);
          },
          showButtonCancel: (state.statusCheck == TripStatus.STARTED ||
                  state.statusCheck == TripStatus.ARRIVED)
              ? true
              : false,
          size: size,
          status: status,
          url: (BASE_URL_STORAGE + provider?.avatar) ?? "",
          rating: provider?.rating ?? "",
          nameProvider:
              provider?.firstName ?? "" + " " + provider?.lastName ?? "",
          job: common.serviceType.providerName ?? "",
          onPressCall: () {
            _launched = bloc.makeCall(provider.mobile);
          },
          onPressMessage: () {
            print('on press message');
          });
    }
    if (state.statusCheck == TripStatus.DROPPED) {
      final data = bloc.state.requestCheckResponse?.data ?? null;
      if (data == null) {
        bloc.changeStatusCheck(status: TripStatus.EMPTY);
        return panelDefaultContent(context, size);
      }

      final dataDropped = bloc.state.requestCheckResponse.data.first;
      final hasDataPayment = dataDropped.payment == null ? false : true;
      return panelStatusDroppedContent(
          context: context,
          data: dataDropped,
          size: size,
          onPressCASH: () {
            print('tap payment invoice');
          },
          onPressDONE: () {
            if (!hasDataPayment) {
              bloc.showDialog(description: 'please_pay_before_completing'.tr);
            }
          });
    }

    if (bloc.state.statusCheck == TripStatus.COMPLETED) {
      // showModalSubmitAndRating(
      //     state: state,
      //     rating: bloc.state.ratingRequest.rating,
      //     comment: bloc.state.ratingRequest.comment,
      //     ratingCallBack: (rating) {
      //       bloc.updateRatingRequest(null, rating);
      //     },
      //     commentCallBack: (comment) {
      //       bloc.updateRatingRequest(comment, null);
      //     },
      //     size: size,
      //     context: context,
      //     urlProvider: dataDropped?.provider?.avatar ?? "",
      //     onPressSubmit: () {
      //       bloc.rateProvider(
      //           comment: bloc.state.ratingRequest.comment,
      //           rating: bloc.state.ratingRequest.rating);
      //     });
      return PanelRatingWidget(
        onPressSubmit: () => bloc.rateProvider(
            comment: bloc.state.ratingRequest.comment,
            rating: bloc.state.ratingRequest.rating),
        rating: bloc.state.ratingRequest.rating,
        commentCallBack: (comment) => bloc.updateRatingRequest(comment, null),
        size: size,
        urlImg: _currentTrip?.provider?.avatar ?? "",
        controller: TextEditingController(),
        ratingCallBack: (rating) => bloc.updateRatingRequest(null, rating),
        title: 'rating_your_request_with_driver_demo'.tr,
      );
    }
    return panelDefaultContent(context, size);
  }

  panelDefaultContent(BuildContext context, Size size) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            color: Colors.grey.withOpacity(0.4),
            child: buildTitlePanel(
                promo: bloc.state.promo?.promoCode ?? 'view_coupons'.tr,
                titleService: service.name,
                onPress: () {
                  bloc.getPromo();
                }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildTextContent(
                      colorRightText: Colors.green,
                      leftText: 'price'.tr,
                      rightText: '${service.price}' + kCurrency),
                  buildTextContent(
                      colorRightText: Colors.green,
                      leftText: 'fixed_rates'.tr,
                      rightText: '${service.fixed}' + kCurrency),
                  if (bloc.state.promo.id != null) ...[
                    buildTextContent(
                        onPressRightText: () {
                          bloc.removePromo();
                        },
                        colorRightText: Colors.redAccent,
                        leftText: 'promo_code'.tr,
                        rightText: 'remove'.tr),
                    buildTextContent(
                        colorRightText: Colors.green,
                        leftText: 'promo_description'.tr,
                        rightText: '${bloc.state.promo.promoDescription}')
                  ],
                  Divider(
                    height: 1,
                  ),
                  buildTextContent(
                      onPressRightText: () {},
                      colorRightText: Colors.blue,
                      // leftText: listItemPayment[bloc.state.selectPayment].tr,
                      // rightText: 'change'.tr,
                      leftText: 'payment'.tr + ":",
                      rightText: 'cash'.tr),
                  Offstage(
                      offstage: false,
                      child: buildUseWalletContent(
                          onChange: (bool) {
                            bloc.changeUseWallet().then((value) {
                              if (value == false) {
                                bloc.showDialog(
                                    description: 'balance_is_not_available'.tr);
                              }
                              if (value == null) {
                                locatorSnackBar.showSnackbar(
                                    message: 'please_wait'.tr);
                              }
                            });
                          },
                          checked: bloc.state.checkUseWallet,
                          colorRightText: Colors.green,
                          rightText: bloc.state.userWallet != null
                              ? "${bloc.state.userWallet.walletBalance.toString()}" +
                                  kCurrency
                              : "")),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //button schedule
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buildRaisedButton(
                            text: 'schedule'.tr,
                            onPress: () {
                              bloc.scheduleServiceBook(service,
                                  address:
                                      bloc.state.myPlace?.formattedAddress ??
                                          "",
                                  latitude: bloc.state.myPlace?.lat ?? 0.0,
                                  longitude: bloc.state.myPlace?.lng ?? 0.0,
                                  paymentMode:
                                      listItemPayment[bloc.state.selectPayment]
                                          .toUpperCase(),
                                  serviceType: service.id);
                            }),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      //button request
                      Expanded(
                        child: buildRaisedButton(
                            isLoading:
                                context.watch<BookingCubit>().state.isLoading,
                            text: 'request'.tr,
                            onPress: () async {
                              // bloc.showSearching(true);
                              // showDiaLogSearching(context, bloc);
                              bloc.sendRequest(
                                  address:
                                      bloc.state.myPlace?.formattedAddress ??
                                          "",
                                  latitude: bloc.state.myPlace?.lat ?? 0.0,
                                  longitude: bloc.state.myPlace?.lng ?? 0.0,
                                  paymentMode:
                                      listItemPayment[bloc.state.selectPayment]
                                          .toUpperCase(),
                                  serviceType: service.id);
                            }),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
