import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/routes.dart';
import 'package:flutter_map_booking/screens/home/cubit/home_cubit.dart';
import 'package:flutter_map_booking/screens/home/widgets/grid_home_widget.dart';
import 'package:flutter_map_booking/screens/home/widgets/options_widget.dart';
import 'package:simplest/simplest.dart';

class HomeScreen extends CubitWidget<HomeCubit, HomeState> {
  static provider() {
    return HomeScreen();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.setup();
    bloc.fetchingData();
    bloc.getNameUser();
  }

  @override
  void listener(BuildContext context, HomeState state) {
    super.listener(context, state);
  }

  @override
  Widget builder(BuildContext context, HomeState state) {
    Size size = MediaQuery.of(context).size;
    final double defaultPadding = 20.0;
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle(defaultPadding, state.userName),
                SizedBox(height: defaultPadding),
                buildSideHome(defaultPadding, size),
                //buildIconOptions(defaultPadding, size),
                Column(
                  children: [
                    buildTitleGridHome(defaultPadding, context, state),
                    GridHomeWidget(
                      size: size,
                      defaultPadding: defaultPadding,
                      listServices: state.listServices,
                    ),
                    SizedBox(
                      height: defaultPadding / 2,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildTitleGridHome(
      double defaultPadding, BuildContext context, HomeState state) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('our_service'.tr, style: heading1.copyWith(fontSize: 22.0)),
          FlatButton(
            padding: EdgeInsets.all(0.0),
            color: Color(0xffF34E3F).withOpacity(0.3),
            child: Text(
              'view_all'.tr,
              style: TextStyle(color: Color(0xffF34E3F)),
            ),
            onPressed: () {
              if (state.listServices.length > 0)
                Navigator.of(context).pushNamed(AppRoute.viewAllServices,
                    arguments: {'services': state.listServices});
            },
          )
        ],
      ),
    );
  }

  buildIconOptions(double defaultPadding, Size size) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding, top: defaultPadding),
      width: size.width,
      height: 90.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: List.generate(
          fakeDataOption.length,
          (index) => OptionsWidget(
            defaultPadding: defaultPadding,
            height: 60,
            text: fakeDataOption[index]['text'],
            color: fakeDataOption[index]['color'],
            icon: fakeDataOption[index]['icon'],
            onPress: () {
              print('click icon home $index');
            },
          ),
        ),
      ),
    );
  }

  buildTitle(double defaultPadding, String name) {
    // final cubitProfile = context.bloc<ProfileCubit>();
    //
    // final name = cubitProfile.state.profileReponse?.firstName ?? "";
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: defaultPadding, bottom: defaultPadding / 3),
            child: Text(
              'hello_name'.tr + name ?? "",
              style: heading1.copyWith(fontSize: 22.0),
            ),
          ),
          Text(
            'what_services_do_you_want_to_use'.tr,
            style:
                textGrey.copyWith(fontSize: 16.0, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }

  buildSideHome(double defaultPadding, Size size) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      width: size.width,
      height: 160.0,
      // child: ListView.builder(
      //     shrinkWrap: true,
      //     scrollDirection: Axis.horizontal,
      //     itemCount: listSideWidget.length,
      //     itemBuilder: (context, index) {
      //       return CardSideWidget(
      //           title: listSideWidget[index]['title'],
      //           subTitle: listSideWidget[index]['subTitle'],
      //           urlImg: listSideWidget[index]['urlImg'],
      //           height: 200);
      //     }),
      child: CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          // viewportFraction: 0.9,
          aspectRatio: 2.0,
        ),
      ),
    );
  }

  final List<Widget> imageSliders = [
    Images.banner0,
    Images.banner1,
    Images.banner2,
    Images.banner3,
    Images.banner4,
  ]
      .map((item) => Container(
            child: Container(
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.asset(item, fit: BoxFit.cover)),
            ),
          ))
      .toList();
}
