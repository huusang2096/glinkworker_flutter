part of 'languages_cubit.dart';

class LanguagesState {
  bool isLoading = false;

  LanguagesState({this.isLoading=false});

  LanguagesState.from(LanguagesState state) {
    this.isLoading = state.isLoading;
  }

  LanguagesState copyWith({bool isLoading}) {
    return LanguagesState(isLoading: isLoading ?? this.isLoading);
  }
}

class LanguagesInitial extends LanguagesState {}

class LanguagesUpdateSuccess extends LanguagesState {}
