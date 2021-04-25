import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/send_request.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/screens/services/cubit/book_time_cubit.dart';
import 'package:flutter_map_booking/screens/services/widgets/button_process_widget.dart';
import 'package:flutter_map_booking/screens/services/widgets/pick_date_widget.dart';
import 'package:horizontal_calendar_widget/date_helper.dart';
import 'package:simplest/simplest.dart';

class BookTimeServiceScreen extends CubitWidget<BookTimeCubit, BookTimeState> {
  final ServicesResponse service;
  final int amount;
  final String ton;
  final SendRequest sendRequest;

  BookTimeServiceScreen(
      {this.service, this.amount, this.ton, this.sendRequest});

  static provider(
      {ServicesResponse service,
      int amount,
      String ton,
      SendRequest sendRequest}) {
    return BlocProvider<BookTimeCubit>(
      create: (context) => BookTimeCubit(),
      child: BookTimeServiceScreen(
        service: service,
        amount: amount,
        ton: ton,
        sendRequest: sendRequest,
      ),
    );
  }

  DateTime pickDateTime = toDateMonthYear(DateTime.now());
  DateTime timeNow = DateTime.now();
  List<DateTime> listTime;
  TextEditingController controller = TextEditingController();
  DateTime pickTime;

  @override
  void afterFirstLayout(BuildContext context) {}

  @override
  void listener(BuildContext context, BookTimeState state) {
    // TODO: implement listener
    super.listener(context, state);
    if (state is SubmitSuccessState) {
      bloc.showDialog(description: state.message).then((value) {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget builder(BuildContext context, BookTimeState state) {
    timeNow = DateTime.now();
    listTime = [
      timeNow.add(Duration(hours: 1)),
      timeNow.add(Duration(hours: 2)),
      timeNow.add(Duration(hours: 3)),
      timeNow.add(Duration(hours: 4)),
      timeNow.add(Duration(hours: 5)),
      timeNow.add(Duration(hours: 6))
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppbar(context, state),
      // bottomNavigationBar: buildBottomContent(
      //   state: state,
      //   nameButton: 'schedule'.tr,
      //   onPress: () {
      //     if (pickTime == null) {
      //       bloc.showDialog(description: 'you_not_select_time'.tr);
      //     } else {
      //       bloc.submitSchedule(
      //           pickTime: pickTime,
      //           pickDateTime: pickDateTime,
      //           sendRequest: sendRequest);
      //     }
      //   },
      // ),
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitleContent(),
                Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                  child: PickDateWidget(
                    dateTimePick: (dateTime) {
                      pickDateTime = dateTime;
                    },
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                buildTitleBodyContent(),
                buildTextFieldTime(state, context),
                // GridView.count(
                //   physics: NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   crossAxisCount: 2,
                //   childAspectRatio: 3.5,
                //   crossAxisSpacing: 20.0,
                //   mainAxisSpacing: 20.0,
                //   children: List.generate(listTime.length,
                //       (index) => buildPickTime(state, index, listTime)),
                // ),
                buildBottomContent(
                  state: state,
                  nameButton: 'schedule'.tr,
                  onPress: () {
                    if (pickTime == null) {
                      bloc.showDialog(description: 'you_not_select_time'.tr);
                    } else {
                      bloc.submitSchedule(
                          pickTime: pickTime,
                          pickDateTime: pickDateTime,
                          sendRequest: sendRequest);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildTextFieldTime(BookTimeState state, BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          errorText: state.errorValidator ?? null,
          hintText: 'select_time_schedule'.tr,
          icon: Icon(
            Icons.timer,
            color: primaryColor,
          )),
      readOnly: true,
      controller: controller,
      onTap: () {
        DatePicker.showTimePicker(context,
            showTitleActions: true,
            showSecondsColumn: false,
            locale: LocaleType.en,
            onChanged: (date) {}, onConfirm: (date) {
          controller.text = hourFormatter.format(date);
          if (timeNow.millisecondsSinceEpoch >= date.millisecondsSinceEpoch) {
            String errorText = 'time_error'.tr;
            bloc.changeErrorText(errorText);
          } else {
            pickTime = date;
            bloc.changeErrorText(null);
          }
        }, currentTime: DateTime.now());
      },
    );
  }

  buildTitleBodyContent() {
    return Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: Text('at_what_time_should_the_service_provider_arrive'.tr,
            style: body1.copyWith(fontWeight: FontWeight.w500)));
  }

  buildTitleContent() {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: Text('when_would_you_like_your_service'.tr,
            style: body1.copyWith(fontWeight: FontWeight.w500)));
  }

  buildPickTime(BookTimeState state, int index, List<DateTime> listTime) {
    return InkWell(
      onTap: () {
        bloc.changeTime(index);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: state.selectHour == index
                      ? Color(0xffF34E3F)
                      : Color(0xffE1E1E1)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0)),
          alignment: Alignment.center,
          child: Text(
            // DateFormat('h:mm a').format(listTime[index].toLocal()),
            hourFormatter.format(listTime[index].toLocal()),
            style: textGrey.copyWith(
                fontSize: 14.0,
                color: state.selectHour == index
                    ? Color(0xffF34E3F)
                    : Color(0xff8A8A8A),
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  buildAppbar(BuildContext context, BookTimeState state) {
    return PreferredSize(
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            //handleOkAndPop(state);
          },
        ),
        title: Text(
          'schedule_service'.tr,
          style: heading1.copyWith(fontSize: 20.0, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  buildBottomContent(
      {Function onPress, String nameButton, BookTimeState state}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          state.isLoading
              ? SpinKitCircle(
                  color: primaryColor,
                )
              : ButtonProcessWidget(
                  onPress: onPress,
                  nameButton: nameButton,
                )
        ],
      ),
    );
  }
}
