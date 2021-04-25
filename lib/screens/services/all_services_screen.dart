import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/services/cubit/service_cubit.dart';
import 'package:flutter_map_booking/screens/services/widgets/app_bar_widget.dart';
import 'package:flutter_map_booking/screens/services/widgets/card_service_widget.dart';
import 'package:flutter_map_booking/screens/services/widgets/modal_select_service_widget.dart';
import 'package:simplest/simplest.dart';

// ignore: must_be_immutable
class AllServicesScreen extends StatelessWidget {
  final List<ServicesResponse> listServices;

  AllServicesScreen({this.listServices});

  static provider(List<ServicesResponse> services) {
    return AllServicesScreen(
      listServices: services,
    );
  }

  buildListView() {
    return ListView.separated(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
      itemCount: listServices.length,
      itemBuilder: (context, index) {
        return CardServiceWidget(
          showTextForm: false,
          onPress: () {
            Navigator.of(context).pushNamed(AppRoute.repairService, arguments: {
              'idService': listServices[index].id,
              'listServices': listServices,
              'navigationBooking': false
            });
          },
          moneyText: listServices[index].price ?? "",
          subTitleText: listServices[index].description ?? "",
          titleText: listServices[index].name ?? "",
          urlImage: listServices[index].image ?? "",
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: 1.0,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color(0xffE1E1E1)),
            ),
          ),
        );
      },
    );
  }

  void showModal(BuildContext context, ServicesResponse item) {
    final cubit = context.bloc<ServiceCubit>();
    final paddingHorizontal = 15.0;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: ModalSelectService(
            paddingHorizontal: paddingHorizontal,
            item: item,
          ),
        );
      },
    ).whenComplete(() async {
      Future.delayed(Duration(milliseconds: 400), () {
        cubit.refreshInit();
      });
    });
  }

  buildAppbar(BuildContext context, String title) {
    return PreferredSize(
      child: AppbarWidget(
        text: title,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context, 'our_service'.tr),
      body: Container(
        color: Colors.white,
        child: SizedBox.expand(
          child: listServices.length == 0
              ? Center(child: CircularProgressIndicator())
              : buildListView(),
        ),
      ),
    );
  }
}
