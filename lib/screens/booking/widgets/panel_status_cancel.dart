import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/cancel_reason_response.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';
import 'package:flutter_map_booking/screens/booking/widgets/content_in_sliding_up_panel.dart';
import 'package:simplest/simplest.dart';

class PanelStatusCancel extends StatefulWidget {
  @override
  _PanelStatusCancelState createState() => _PanelStatusCancelState();
}

class _PanelStatusCancelState extends State<PanelStatusCancel> {
  final _formKey = new GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<CancelReasonResponse> cancelReason =
        context.watch<BookingCubit>().state.cancelReason;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListView.builder(
                padding: EdgeInsets.all(5),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cancelReason.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      context.read<BookingCubit>().selectCancelReason(index);
                    },
                    title: Text(
                      "${cancelReason[index].reason}",
                      style: body1,
                    ),
                    leading: context
                                .read<BookingCubit>()
                                .state
                                .selectedCancelReason ==
                            index
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.black,
                          )
                        : Icon(
                            Icons.check_circle,
                            color: Colors.grey,
                          ),
                  );
                }),
            Form(
              key: _formKey,
              child: TextFormField(
                enabled:
                    context.watch<BookingCubit>().state.selectedCancelReason ==
                            3
                        ? true
                        : false,
                controller: controller,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return 'cancellation_reason_must_not_be_blank_and_at_least_characters'
                        .tr;
                  }
                  if (value.length > 255) {
                    return 'cancellation_reason_must_not_be_blank_and_at_least_characters'
                        .tr;
                  }
                  return null;
                },
                autocorrect: false,
                maxLines: null,
                onChanged: (value) {
                  int index =
                      context.watch<BookingCubit>().state.selectedCancelReason;
                  if (index == 3) {
                    context.read<BookingCubit>().updateCancelRequest(value);
                  } else {
                    context
                        .read<BookingCubit>()
                        .updateCancelRequest(cancelReason[index].reason);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'write_your_reason'.tr,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.8))),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.redAccent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.6))),
                ),
              ),
            ),
            Divider(),
            context.watch<BookingCubit>().state.isDisablePanel
                ? SpinKitCircle(
                    color: primaryColor,
                  )
                : Row(children: [
                    Expanded(
                      child: buildRaisedButton(
                          onPress: () {},
                          // onPress: () => context
                          //     .read<BookingCubit>()
                          //     .handleDismissCancelRequest(),
                          text: 'dismiss'.tr,
                          colorButton: Colors.black,
                          colorText: Colors.white),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: buildRaisedButton(
                          text: 'submit'.tr,
                          onPress: () {
                            int index = context
                                .read<BookingCubit>()
                                .state
                                .selectedCancelReason;
                            print("Index${index}");
                            if (index == 3) {
                              if (_formKey.currentState.validate()) {
                                context
                                    .read<BookingCubit>()
                                    .updateCancelRequest(controller.text);
                                context
                                    .read<BookingCubit>()
                                    .submitReasonCancel();
                              }
                            }
                            if (index != 3) {
                              context.read<BookingCubit>().updateCancelRequest(
                                  cancelReason[index].reason);
                              context.read<BookingCubit>().submitReasonCancel();
                            }
                            return;
                          }),
                    ),
                  ])
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
