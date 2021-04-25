import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/user_wallet/cubit/payment_cubit.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_add_money_request_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simplest/simplest.dart';

class UserPaymentScreen extends CubitWidget<PaymentCubit, PaymentState> {
  final int amount;
  bool requestGoto;
  UserAddMoneyRequest userAddMoneyRequest = new UserAddMoneyRequest();

  UserPaymentScreen({this.amount, this.requestGoto});

  static provider({int amount, bool requestGoto}) {
    return BlocProvider<PaymentCubit>(
      create: (context) => PaymentCubit(),
      child: UserPaymentScreen(amount: amount, requestGoto: requestGoto),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getUserPayment();
  }

  @override
  Widget builder(BuildContext context, PaymentState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'payment'.tr,
          style: heading1,
        ),
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
    );
  }

  _showDialogConfirm(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Glink Work"),
            content: Text("Delete card ?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    bloc.deleteCardPayment(
                        userAddMoneyRequest.cardId, "DELETE");
                  },
                  child: Text("Yes")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  _buildBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.moneyBill,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 20,
                ),
                Text('by_cash'.tr),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Image.asset(Images.credit_card_icon),
                SizedBox(
                  width: 20,
                ),
                Text('credit_card'.tr),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'card_payment'.tr,
              style: heading1,
            ),
          ),
          _buildListCard(context),
          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pushNamed(AppRoute.addCardScreen,
          //         arguments: {'amount': amount}).then((value) {
          //       bloc.getUserPayment();
          //     });
          //   },
          //   child: Container(
          //     padding: EdgeInsets.all(20),
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       "add_card_for_payment".tr,
          //       style: body1,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  _buildListCard(BuildContext context) {
    if (bloc.state.userCard == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (bloc.state.userCard.length == 0) {
      return SizedBox();
    } else if (bloc.state.userCard != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: bloc.state.userCard.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                userAddMoneyRequest.cardId = bloc.state.userCard[index].cardId;
                _showDialogConfirm(context);
              },
              onTap: () {
                if (requestGoto) {
                  Navigator.of(context)
                      .pop({'userCard': bloc.state.userCard[index]});
                } else {
                  /* userAddMoneyRequest.cardId =
                      bloc.state.userCard[index].cardId;
                  userAddMoneyRequest.amount = amount;
                  bloc.addMoney(userAddMoneyRequest);*/
                }
              },
              trailing: context
                          .bloc<PaymentCubit>()
                          .state
                          .userCard[index]
                          .isDefault ==
                      1
                  ? Icon(Icons.check_circle)
                  : Text(" "),
              title: Text(
                "XXXX-XXXX-XXXX-" +
                        context
                            .bloc<PaymentCubit>()
                            .state
                            .userCard[index]
                            .lastFour
                            .toString() ??
                    "",
                style: body1,
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void listener(BuildContext context, PaymentState state) {
    super.listener(context, state);
    if (state is DeleteCardPaymentSuccess) {
      // showPopUp(context, state.message.message.tr);
      bloc.getUserPayment();
    }
    if (state is PaymentAddMoneySuccess) {
      Navigator.of(context).pushNamed(AppRoute.walletScreen);
    }
  }
}
