import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';
import 'package:flutter_map_booking/screens/booking/widgets/panel_rating_widget.dart';
import 'package:simplest/simplest.dart';

buildTitlePanel({String titleService, Function onPress, String promo}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
          child: Text(titleService,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: body1.copyWith(fontSize: 17.0))),
      Flexible(
        child: FlatButton(
          color: Colors.black,
          onPressed: () {
            onPress();
          },
          child: Text(
            promo,
            style: body2.copyWith(color: Colors.white, fontSize: 13.0),
          ),
        ),
      )
    ],
  );
}

buildTextContent(
    {String leftText,
    rightText,
    Color colorRightText,
    Function onPressRightText,
    bool isShow}) {
  return Offstage(
    offstage: false,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              leftText,
              style: body1.copyWith(fontSize: 15.0),
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                if (onPressRightText != null) onPressRightText();
              },
              child: Text(rightText,
                  style: body1.copyWith(fontSize: 15.0, color: colorRightText)),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildRaisedButton(
    {String text,
    Function onPress,
    Color colorButton,
    Color colorText,
    bool isLoading = false}) {
  TextStyle textStyle = button;
  if (colorButton == null) {
    colorButton = Color(0xffF34E3F);
  }
  if (colorText != null) {
    textStyle.copyWith(color: colorText);
  }
  return SizedBox(
    height: 44,
    child: RaisedButton(
      color: colorButton,
      onPressed: () {
        onPress();
      },
      child: isLoading
          ? SpinKitCircle(
              color: Colors.white,
              size: 30,
            )
          : Text(
              text,
              style: textStyle,
            ),
    ),
  );
}

showDiaLogSearching(BuildContext context, BookingCubit bloc) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          children: [
            Center(
              child: Column(children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'searching'.tr,
                  style: TextStyle(color: Colors.blueAccent),
                ),
                FutureBuilder(
                    future: Future.delayed(Duration(seconds: 4), () => true),
                    builder: (c, s) {
                      if (s.hasData) {
                        return Container(
                          child: RaisedButton(
                            color: primaryColor,
                            onPressed: () {
                              if (bloc.state.isShowLoadingSearch) {
                                Navigator.of(context).pop();
                                bloc.showSearching(false);
                              }
                            },
                            child: Text('dismiss'.tr, style: button),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    })
              ]),
            )
          ],
        );
      });
}

buildCardProvider(
    {String url, String nameProvider, String job, String rating}) {
  return Container(
      margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 10.0),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            width: 75,
            height: 75,
            child: CachedNetworkImage(
              imageUrl: url,
              memCacheWidth: 500,
              placeholder: (context, string) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              },
              errorWidget: (context, string, dynamic) {
                return Container(
                  width: 75,
                  height: 75,
                  child: Center(
                    child: Icon(Icons.error),
                  ),
                );
              },
              imageBuilder: (context, img) {
                return Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: img, fit: BoxFit.fill),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameProvider,
                    overflow: TextOverflow.ellipsis,
                    style: body2,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    job,
                    overflow: TextOverflow.ellipsis,
                    style: textGrey,
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 70.0,
              maxHeight: 30.0,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffddd6d5)),
                color: Color(0xfffef2f1),
                borderRadius: BorderRadius.all(Radius.circular(3.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.star,
                  color: Color(0xfff34e3f),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$rating',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: caption.copyWith(
                        color: Color(
                          0xfff34e3f,
                        ),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                )
              ],
            ),
          )
        ],
      ));
}

panelStatusStarted(
    {Function onPressCancel,
    bool showButtonCancel,
    String url,
    String nameProvider,
    String job,
    String rating,
    Function onPressCall,
    Function onPressMessage,
    String status,
    Size size}) {
  return Container(
    child: Column(
      children: [
        buildSeperator(size),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildCardProvider(
                    job: job,
                    nameProvider: nameProvider,
                    rating: rating,
                    url: url),
                buildStatusInPanelContent(status),
                SizedBox(height: 3.0),
                showButtonCancel
                    ? SizedBox(
                        width: Get.width * 0.5,
                        child: buildRaisedButton(
                            text: 'cancel'.tr,
                            onPress: () {
                              onPressCancel();
                            }),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Container buildSeperator(Size size) {
  return Container(
    margin: EdgeInsets.only(top: 5.0),
    width: size.width * 0.4,
    height: 5.0,
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(5.0))),
  );
}

buildStatusInPanelContent(String status) {
  String key = "";
  switch (status) {
    case 'STARTED':
      key = "provier_accepted_your_request";
      break;
    case 'ARRIVED':
      key = "partner_has_arrived_at_your_location";
      break;
    case 'PICKEDUP':
      key = "service_is_live";
      break;
    default:
      key = "";
      break;
  }
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
    width: double.infinity,
    child: Row(
      children: [
        SizedBox(
          width: 8.0,
          height: 8.0,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.redAccent)),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
            child: Text(key.tr,
                maxLines: 2, overflow: TextOverflow.ellipsis, style: body2)),
      ],
    ),
  );
}

buildPaymentInvoice({String leftText, String rightText, Function onPress}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Row(
      children: [
        Flexible(
          child: Text(
            leftText,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: body1.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              onPress();
            },
            child: Text(rightText,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: body1.copyWith(
                    color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ),
  );
}

buildButtonDoneInvoice({String text, Function onPress}) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    height: 46.0,
    child: RaisedButton(
      color: Colors.redAccent,
      child: Text(
        text,
        style: button,
      ),
      onPressed: () {
        onPress();
      },
    ),
  );
}

buildItemInvoiceContent(
    {String leftText, String rightText, bool isBold, showMoney, isLoading}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            leftText,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: isBold ? body1.copyWith(fontWeight: FontWeight.bold) : body1,
          ),
        ),
        Expanded(
          child: isLoading
              ? Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Text(showMoney ? "$rightText" : rightText,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: isBold
                      ? body1.copyWith(fontWeight: FontWeight.bold)
                      : body1),
        ),
      ],
    ),
  );
}

panelStatusDroppedContent(
    {BuildContext context,
    Size size,
    Datum data,
    Function onPressCASH,
    Function onPressDONE}) {
  final hasDataPayment = data.payment == null ? false : true;

  return data != null
      ? Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: size.width,
                  child: Center(child: buildSeperator(size))),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    'invoice'.tr,
                    style: heading1.copyWith(fontSize: 22.0),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildItemInvoiceContent(
                                showMoney: false,
                                leftText: 'booking_id'.tr,
                                isBold: false,
                                rightText: data.bookingId ?? '0',
                                isLoading: !hasDataPayment),
                            buildItemInvoiceContent(
                                showMoney: true,
                                leftText: 'base_charge'.tr,
                                isBold: false,
                                rightText: data.payment?.fixed != null
                                    ? currencyFormatter
                                        .format(data.payment.fixed)
                                    : '0',
                                isLoading: !hasDataPayment),
                            buildItemInvoiceContent(
                                showMoney: true,
                                leftText: 'tax'.tr,
                                isBold: false,
                                rightText: data.payment?.tax != null
                                    ? currencyFormatter.format(data.payment.tax)
                                    : '0',
                                isLoading: !hasDataPayment),
                            buildItemInvoiceContent(
                                showMoney: true,
                                leftText: 'total'.tr,
                                isBold: true,
                                rightText: data.payment?.total != null
                                    ? currencyFormatter
                                        .format(data.payment.total)
                                    : '0',
                                isLoading: !hasDataPayment),
                            Divider(
                              thickness: 1,
                            ),
                            buildItemInvoiceContent(
                                showMoney: true,
                                leftText: 'wallet'.tr,
                                isBold: false,
                                rightText: data.payment?.wallet != null
                                    ? currencyFormatter
                                        .format(data.payment.wallet)
                                    : '0',
                                isLoading: !hasDataPayment),
                            buildItemInvoiceContent(
                                showMoney: true,
                                leftText: 'discount'.tr,
                                isBold: false,
                                rightText: data.payment?.discount != null
                                    ? currencyFormatter
                                        .format(data.payment.discount)
                                    : '0',
                                isLoading: !hasDataPayment),
                            buildItemInvoiceContent(
                                showMoney: true,
                                leftText: 'payable'.tr,
                                isBold: true,
                                rightText: (data.payment?.total != null &&
                                        data.payment?.discount != null &&
                                        data.payment?.tax != null &&
                                        data.payment?.wallet != null)
                                    ? currencyFormatter.format(
                                        (data.payment.total -
                                            data.payment.discount -
                                            data.payment.tax -
                                            data.payment.wallet))
                                    : '0',
                                isLoading: !hasDataPayment),
                            Divider(
                              thickness: 1,
                            ),
                            buildPaymentInvoice(
                              rightText: 'cash'.tr,
                              leftText: 'payment_title'.tr,
                              onPress: () {
                                onPressCASH();
                              },
                            ),
                            buildButtonDoneInvoice(
                                text: 'done'.tr,
                                onPress: () {
                                  onPressDONE();
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      : Container(child: Center(child: CircularProgressIndicator()));
}

// showModalSubmitAndRating(
//     {BuildContext context,
//     BookingState state,
//     Size size,
//     String urlProvider,
//     int rating,
//     String comment,
//     Function(int) ratingCallBack,
//     Function(String) commentCallBack,
//     Function() onPressSubmit}) {
//   TextEditingController controller =
//       new TextEditingController(text: comment ?? "");
//   showModalBottomSheet(
//       isDismissible: false,
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return state.isLoading
//             ? Center(
//                 child: SpinKitCircle(
//                   color: primaryColor,
//                 ),
//               )
//             : ModalRatingCommentWidget(
//                 rating: rating,
//                 size: size,
//                 title: 'rating_your_request_with_driver_demo'.tr,
//                 urlImg: BASE_URL_STORAGE + urlProvider,
//                 commentCallBack: (result) {
//                   commentCallBack(result);
//                   print(result);
//                 },
//                 ratingCallBack: (result) {
//                   ratingCallBack(result);
//                   print(result);
//                 },
//                 onPressSubmit: () {
//                   onPressSubmit();
//                 },
//                 controller: controller,
//               );
//       }).whenComplete(() => controller.dispose());
// }

final spinkit = SpinKitFadingCircle(
  itemBuilder: (BuildContext context, int index) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? Colors.red : Colors.white,
      ),
    );
  },
);

buildSearchingPanelContent(
    {Function onPress, String text, BookingState state}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
    child: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              spinkit,
              SizedBox(
                width: 20,
              ),
              Text(text, style: body1)
            ]),
            SizedBox(
              height: 20,
            ),
            state.isDisablePanel
                ? Center(
                    child: SpinKitCircle(
                      color: primaryColor,
                    ),
                  )
                : SizedBox(
                    width: Get.width * 0.7,
                    child: buildRaisedButton(
                        text: 'cancel'.tr,
                        onPress: () {
                          onPress();
                        }),
                  ),
          ],
        ),
      ),
    ),
  );
}

dialogPayment({List<String> listItemPayment, int currentIndex}) {
  return BlocConsumer<BookingCubit, BookingState>(
    listener: (context, state) {},
    builder: (context, state) {
      return AlertDialog(
        title: Text('select_payment'.tr),
        contentPadding: EdgeInsets.only(top: 12.0),
        content: SingleChildScrollView(
          child: ListTileTheme(
            contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
            child: ListBody(
                children: listItemPayment
                    .asMap()
                    .map((index, e) {
                      return MapEntry(
                        index,
                        _buildItemDialogPayment(
                            onChange: () {
                              context
                                  .bloc<BookingCubit>()
                                  .changeSelectPayment(index);
                            },
                            titleKey: listItemPayment[index],
                            check: state.selectPayment == index ? true : false),
                      );
                    })
                    .values
                    .toList()),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('cancel'.tr, style: TextStyle(color: Colors.redAccent)),
            onPressed: () {
              context.bloc<BookingCubit>().changeSelectPayment(currentIndex);
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('ok'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

Widget _buildItemDialogPayment(
    {String titleKey, bool check, Function onChange}) {
  return RadioListTile(
    groupValue: true,
    value: check,
    title: Text(
      titleKey.tr,
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    controlAffinity: ListTileControlAffinity.leading,
    activeColor: Colors.redAccent,
    onChanged: (e) {
      onChange();
    },
  );
}

buildUseWalletContent(
    {bool checked,
    String rightText,
    Color colorRightText,
    Function onPressRightText,
    Function(bool) onChange}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            child: Row(
              children: [
                Container(
                  width: 30.0,
                  height: 30.0,
                  child: Checkbox(
                    value: checked,
                    activeColor: primaryColor,
                    onChanged: (bool) {
                      onChange(bool);
                    },
                  ),
                ),
                Text('use_wallet'.tr, style: body1.copyWith(fontSize: 15.0))
              ],
            ),
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              if (onPressRightText != null) onPressRightText();
            },
            child: Text(rightText,
                style: body1.copyWith(fontSize: 15.0, color: colorRightText)),
          ),
        ),
      ],
    ),
  );
}
