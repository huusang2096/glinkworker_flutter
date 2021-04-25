import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/order_history/cubit/complete_task_cubit.dart';
import 'package:flutter_map_booking/screens/order_history/models/rate_star_model.dart';
import 'package:flutter_map_booking/screens/order_history/widgets/rate_star_widget.dart';
import 'package:flutter_map_booking/screens/order_history/widgets/text_input_widget.dart';
import 'package:flutter_map_booking/screens/order_history/widgets/tips_widget.dart';
import 'package:simplest/simplest.dart';

class RateNowModalWidget extends StatelessWidget {
  RateNowModalWidget();

  final List<String> listTips = ['5', '10', '15', '20'];

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<CompleteTaskCubit>();
    return BlocConsumer<CompleteTaskCubit, CompleteTaskState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.70,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      alignment: Alignment.center,
                      child: Text(
                        'thank_you'.tr,
                        style: heading1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        'how_satisfied_are_you_with_jm'.tr,
                        style: body1.copyWith(color: greyColor),
                      ),
                    ),

                    _buildSelectRateStar(cubit, state),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildFeedbackInput(context),
                    Container(
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        'do_you_give_any_tip'.tr,
                        style:
                            body1.copyWith(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                    //  card
                    _buildSelectTip(
                      cubit,
                      state,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'enter_custom_account'.tr,
                        style: body1.copyWith(color: redColor2, fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _buildBottomButton(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  _buildFeedbackInput(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: InputTextField(
          color: Colors.white,
          placeholder: 'your_feedback'.tr,
          maxLines: 7,
        ));
  }

  _buildBottomButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
          color: redColor2, borderRadius: BorderRadius.circular(20)),
      child: Text(
        'submit'.tr,
        style: headingWhite.copyWith(fontSize: 20),
      ),
    );
  }

  _buildSelectRateStar(CompleteTaskCubit cubit, CompleteTaskState state) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          rateStars.length,
          (index) => RateStar(
            icons: rateStars[index].iconUrl,
            iconColor: state.rateStar == index ? Colors.yellow : Colors.grey,
            onPressTip: () {
              cubit.selectRateStar(index);
            },
          ),
        ),
      ),
    );
  }

  _buildSelectTip(CompleteTaskCubit cubit, CompleteTaskState state) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          listTips.length,
          (index) => TipWidget(
            colorText: redColor2,
            textTip: listTips[index] + kCurrency,
            colorBackground: state.tips == index
                ? Color(0xffFEF2F1)
                : redColor2.withOpacity(0.3),
            onPressTip: () {
              cubit.selectTips(index);
            },
          ),
        ),
      ),
    );
  }
}
