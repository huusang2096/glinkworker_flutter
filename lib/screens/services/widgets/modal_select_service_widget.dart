import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/services/cubit/service_cubit.dart';
import 'package:flutter_map_booking/screens/services/widgets/card_service_widget.dart';
import 'package:flutter_map_booking/screens/services/widgets/ton_widget.dart';
import 'package:flutter_map_booking/screens/services/widgets/total_widget.dart';
import 'package:simplest/simplest.dart';

class ModalSelectService extends StatelessWidget {
  ModalSelectService({
    Key key,
    @required this.paddingHorizontal,
    this.item,
  }) : super(key: key);

  final double paddingHorizontal;
  final ServicesResponse item;

  final List<String> listTon = ['1 TON', '1.5 TON', '2 TON', '3 TON', '5 TON'];

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<ServiceCubit>();
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          width: double.infinity,
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.70,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  children: [
                    //  card
                    buildCardWidget(),

                    //text select ton
                    SizedBox(
                      child: Text(
                        'select_ton'.tr,
                        style: heading1.copyWith(fontSize: 16.0),
                      ),
                    ),

                    //choose ton
                    buildSelectTonWidget(state, cubit),

                    //button increment, decrement
                    buildAmountWidget(state, cubit),

                    //divider
                    Divider(
                      thickness: 1,
                    ),

                    //add more service
                    buildAddMoreServiceWidget(),

                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
              buildTotalWidget(context, cubit, state)
            ],
          ),
        );
      },
    );
  }

  buildAddMoreServiceWidget() {
    return Column(
      children: [
        Row(
          children: [
            buildButtonIncrement(() {}),
            SizedBox(
              width: 10.0,
            ),
            Text('add_more_service'.tr,
                style: textStyleActive.copyWith(
                    fontSize: 14.0, fontWeight: FontWeight.w500))
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: new ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 250.0, minHeight: 80.0),
            child: new Scrollbar(
              child: new SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: new TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15.0),
                      hintText: 'written_here'.tr,
                      border: InputBorder.none),
                  maxLines: null,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  buildTotalWidget(
      BuildContext context, ServiceCubit cubit, ServiceState state) {
    return TotalWidget(
      total: item.price * state.amount,
      onPress: () {
        Navigator.of(context).pushNamed(AppRoute.bookTimeServiceScreen,
            arguments: {
              'item': item,
              'amount': state.amount,
              'ton': listTon[state.selectTon]
            });
      },
      nameButton: 'Process',
    );
  }

  buildAmountWidget(ServiceState state, ServiceCubit cubit) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${(item.price * state.amount)}' + kCurrency,
                    style: heading1.copyWith(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                      text: ' / unit',
                      style: body2.copyWith(
                          color: Colors.grey,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400))
                ],
              ),
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                buildButtonDecrement(() {
                  if (state.amount > 1) cubit.changeAmountDecrement();
                }),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('${state.amount}',
                        style: body1.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 18.0))),
                buildButtonIncrement(() {
                  cubit.changeAmountIncrement();
                })
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildSelectTonWidget(ServiceState state, ServiceCubit cubit) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          listTon.length,
          (index) => TonWidget(
            colorText:
                state.selectTon == index ? Color(0xffF34E3F) : Colors.black,
            textTon: listTon[index],
            colorBackground: state.selectTon == index
                ? Color(0xffFEF2F1)
                : Color(0xffF5F5F5),
            onPressTon: () {
              cubit.changeSelectTon(index);
            },
          ),
        ),
      ),
    );
  }

  buildCardWidget() {
    return Container(
      padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
      child: CardServiceWidget(
        showTextForm: false,
        maxHeight: 110.0,
        urlImage: item.image,
        onPress: () {
          print('click item in bottom sheer');
        },
        titleText: item.name ?? "",
        subTitleText: item.description ?? "",
        moneyText: item.price ?? "",
      ),
    );
  }

  buildButtonIncrement(Function onTap) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFEF2F1),
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(13.0)),
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                child: SizedBox(
                  width: 17.0,
                  height: 2.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Color(0xffF34E3F)),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
                width: 2.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xffF34E3F)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildButtonDecrement(Function onTap) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFEF2F1),
          borderRadius: BorderRadius.all(Radius.circular(13.0))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.all(Radius.circular(13.0)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
            child: SizedBox(
              width: 17.0,
              height: 2.0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffF34E3F)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
