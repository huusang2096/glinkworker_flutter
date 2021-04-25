import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/user_wallet/cubit/wallet_cubit.dart';
import 'package:flutter_map_booking/screens/user_wallet/models/user_wallet_response_model.dart';
import 'package:flutter_map_booking/screens/user_wallet/widgets/text_input_widget.dart';
import 'package:simplest/simplest.dart';

class WalletScreen extends CubitWidget<WalletCubit, WalletState> {
  TextEditingController _txtController = TextEditingController();
  List<WalletTransation> userWalletTransaction;

  static provider() {
    return BlocProvider(
      create: (context) => WalletCubit(),
      child: WalletScreen(),
    );
  }

  _buildBody(BuildContext context, WalletState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeaderContent(context, state),
          SizedBox(
            height: 40,
          ),
/*
          _buildAddAmount(context),
*/
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: _buildDepositContent(context, state),
          )
        ],
        /*),*/
      ),
    );
  }

  _buildHeaderContent(BuildContext context, WalletState state) {
    if (state.isLoading) {
      return Center(
        child: SpinKitCircle(
          color: primaryColor,
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(Images.wallet_icon),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text(
              "your_wallet_amount".tr,
              style: heading1.copyWith(fontSize: 15, color: greyColor),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.red,
                  size: 40,
                ),
                Container(
                  child: Text(
                      context
                              .watch<WalletCubit>()
                              .state
                              .userWallet
                              ?.walletBalance
                              .toString() ??
                          "",
                      style:
                          heading1.copyWith(color: Colors.red, fontSize: 30)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildAddAmount(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'enter_amount'.tr,
              style: body1.copyWith(fontSize: 20),
            ),
            InputTextField(
              suffixIconText: 'add_amount',
              placeholder: "100",
              inputType: TextInputType.number,
              controller: _txtController,
              suffixOntap: () {
                if (_txtController.text.toString().length == 0 ||
                    _txtController.text == null) {
                } else {
                  Navigator.of(context)
                      .pushNamed(AppRoute.paymentScreen, arguments: {
                    'amount': int.parse(
                      _txtController.text.toString(),
                    ),
                    'requestGoto': false
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }

  _buildDepositContent(BuildContext context, WalletState state) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: greyColor)),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Stack(
          children: <Widget>[
            _buildListDeposit(context, state),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: redColor2, borderRadius: BorderRadius.circular(5)),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      child: Text(
                        "transaction_id".tr,
                        style: textStyleWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30),
                      child: Text("date".tr, style: textStyleWhite),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 10),
                      child: Text("amount".tr, style: textStyleWhite),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getUserWallet();
  }

  @override
  void listener(BuildContext context, WalletState state) {
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, WalletState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: Text(
          'wallet'.tr,
          style: heading1,
        ),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(context, state),
    );
  }

  _buildListDeposit(BuildContext context, WalletState state) {
    bool isEmpty = (state.userWallet?.walletTransation ?? []).isEmpty;
    if (state.isLoading) {
      return Center(
        child: SpinKitCircle(
          color: primaryColor,
        ),
      );
    }
    if (isEmpty) {
      return Container(
        alignment: Alignment.center,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: greyColor)),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.2,
        child: Text(
          'no_wallet_history'.tr,
          style: body1.copyWith(color: redColor2),
        ),
      );
    }

    userWalletTransaction =
        context.watch<WalletCubit>().state.userWallet.walletTransation;
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
        itemCount: context
            .bloc<WalletCubit>()
            .state
            .userWallet
            .walletTransation
            .length,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                child: Text(
                  userWalletTransaction[index].id.toString(),
                  textAlign: TextAlign.center,
                  style: body1,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  userWalletTransaction[index].createdAt.toString(),
                  textAlign: TextAlign.center,
                  style: body1,
                ),
              ),
              Expanded(
                child: Container(
                  child: Text(
                    userWalletTransaction[index].amount.toString(),
                    textAlign: TextAlign.center,
                    style: body1,
                  ),
                  padding: EdgeInsets.only(top: 10),
                ),
              ),
            ],
          );
        });
  }
}
