import 'dart:ui';

import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:meta/meta.dart';
import 'package:simplest/simplest.dart';

part 'languages_state.dart';

class LanguagesCubit extends BaseCubit<LanguagesState> {
  LanguagesCubit() : super(LanguagesInitial());

  onSelectLocale(Locale locale) async {
    try {
      emit(state.copyWith(isLoading: true));
      await dataRepository.updateLanguage(langCode: locale.languageCode);
      appPref.langCode = locale.languageCode;
      Get.updateLocale(locale);
      dataRepository.loadAuthHeader();
      emit(state.copyWith(isLoading: false));
      emit(LanguagesUpdateSuccess());
    } catch (error) {
      handleAppError(error);
    }
  }
}
