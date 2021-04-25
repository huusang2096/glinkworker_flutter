import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/schedule_service_request.dart';
import 'package:horizontal_calendar_widget/date_helper.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';

const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class PickDateWidget extends StatefulWidget {
  final Function(DateTime) dateTimePick;

  const PickDateWidget({Key key, this.dateTimePick}) : super(key: key);

  @override
  _PickDateWidgetState createState() => _PickDateWidgetState();
}

class _PickDateWidgetState extends State<PickDateWidget> {
  DateTime firstDate;
  DateTime lastDate;
  String dateFormat = 'dd';
  String monthFormat = 'MMM';
  String weekDayFormat = 'EEE';
  bool forceRender = false;

  Color defaultDecorationColor = Colors.transparent;
  BoxShape defaultDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusDefault = true;

  Color selectedDecorationColor = Color(0xffFEF2F1);
  BoxShape selectedDecorationShape = BoxShape.rectangle;
  bool isCircularRadiusSelected = true;

  int minSelectedDateCount = 1;
  int maxSelectedDateCount = 1;
  RangeValues selectedDateCount;

  TextStyle selectTextStyle = body1.copyWith(
      color: Color(0xffF34E3F), fontSize: 15.0, fontWeight: FontWeight.w400);

  List<DateTime> initialSelectedDates;

  TextStyle selectDateStyle = heading1.copyWith(
    fontSize: 20.0,
    color: Color(0xffF34E3F),
  );
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    const int days = 30;
    firstDate = toDateMonthYear(DateTime.now());
    lastDate = toDateMonthYear(firstDate.add(Duration(days: days)));

    selectedDateCount = RangeValues(
      minSelectedDateCount.toDouble(),
      maxSelectedDateCount.toDouble(),
    );
    // if (widget.scheduleRequest.pickTime != null &&
    //     widget.scheduleRequest.pickDate != null) {
    //   initialSelectedDates = feedInitialSelectedDates(
    //       minSelectedDateCount, days,
    //       scheduleRequest: widget.scheduleRequest);
    //   print("${firstDate.year}, ${firstDate.month}, ${firstDate.day}");
    //   print(
    //       " ${widget.scheduleRequest.pickDate.year},${widget.scheduleRequest.pickDate.month},${widget.scheduleRequest.pickDate.day}");
    //   DateTime now =
    //       DateTime.utc(firstDate.year, firstDate.month, firstDate.day);
    //   DateTime pick = DateTime.utc(
    //       widget.scheduleRequest.pickDate.year,
    //       widget.scheduleRequest.pickDate.month,
    //       widget.scheduleRequest.pickDate.day);
    //   int offSet = now.difference(pick).inDays;
    //   if (offSet < 0) {
    //     offSet = offSet * -1;
    //   }
    //   print("offSet $offSet");
    //   _scrollController =
    //       ScrollController(initialScrollOffset: (offSet - 1) * 80.0);
    // } else {
    //   initialSelectedDates =
    //       feedInitialSelectedDates(minSelectedDateCount, days);
    // }
    initialSelectedDates = feedInitialSelectedDates(minSelectedDateCount, days);
  }

  List<DateTime> feedInitialSelectedDates(int target, int calendarDays,
      {ScheduleRequest scheduleRequest}) {
    List<DateTime> selectedDates = List();
    DateTime date;
    if (scheduleRequest != null) {
      date = toDateMonthYear(scheduleRequest.pickDate);
    } else {
      date = firstDate;
    }
    selectedDates.add(date);
    return selectedDates;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 5.0),
        HorizontalCalendar(
          onDateSelected: (date) {
            widget.dateTimePick(date);
          },
          scrollController: _scrollController,
          dateTextStyle: selectDateStyle.copyWith(color: Colors.grey),
          weekDayTextStyle: selectTextStyle.copyWith(color: Colors.grey),
          monthTextStyle: selectTextStyle.copyWith(color: Colors.grey),
          selectedWeekDayTextStyle: selectTextStyle,
          selectedMonthTextStyle: selectTextStyle,
          selectedDateTextStyle: selectDateStyle,
          spacingBetweenDates: 30.0,
          key: forceRender ? UniqueKey() : Key('Calendar'),
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          firstDate: firstDate,
          lastDate: lastDate,
          dateFormat: dateFormat,
          weekDayFormat: weekDayFormat,
          monthFormat: monthFormat,
          defaultDecoration: BoxDecoration(
            color: defaultDecorationColor,
            shape: defaultDecorationShape,
            borderRadius: defaultDecorationShape == BoxShape.rectangle &&
                    isCircularRadiusDefault
                ? BorderRadius.circular(12)
                : null,
          ),
          selectedDecoration: BoxDecoration(
            color: selectedDecorationColor,
            shape: selectedDecorationShape,
            borderRadius: selectedDecorationShape == BoxShape.rectangle &&
                    isCircularRadiusSelected
                ? BorderRadius.circular(12)
                : null,
          ),
          labelOrder: [
            LabelType.month,
            LabelType.date,
            LabelType.weekday,
          ],
          minSelectedDateCount: minSelectedDateCount,
          maxSelectedDateCount: maxSelectedDateCount,
          initialSelectedDates: initialSelectedDates,
        ),
      ],
    );
  }
}
