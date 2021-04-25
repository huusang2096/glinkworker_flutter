import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter_map_booking/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class LanguagesScreen extends CubitWidget<LanguagesCubit, LanguagesState> {
  static provider() {
    return BlocProvider(
      create: (_) => LanguagesCubit(),
      child: LanguagesScreen(),
    );
  }

  @override
  Widget builder(BuildContext context, LanguagesState state) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('languages'.tr),
      ),
      body: state.isLoading
          ? Center(
              child: SpinKitCircle(
                color: primaryColor,
              ),
            )
          : ListView.separated(
              itemBuilder: (_, index) => _itemWidget(index),
              separatorBuilder: (_, index) => Divider(
                    height: 1.0,
                  ),
              itemCount: supportedLocales.length),
    );
  }

  _itemWidget(int index) {
    final _locale = supportedLocales[index];
    final _isSelected = Get.locale.languageCode == _locale.languageCode;
    return InkWell(
      onTap: () => bloc.onSelectLocale(_locale),
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Container(
              width: 50,
              child: Center(
                child: _isSelected
                    ? FaIcon(
                        FontAwesomeIcons.check,
                        color: primaryColor,
                      )
                    : SizedBox.shrink(),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _locale.languageCode == 'vi'
                  ? Images.vnFlag.loadImage(size: 40)
                  : Images.enFlag.loadImage(size: 40),
            ),
            Expanded(
              child: Text(
                _locale.languageCode.tr,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
