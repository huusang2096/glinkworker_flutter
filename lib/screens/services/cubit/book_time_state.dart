part of 'book_time_cubit.dart';

class BookTimeState {
  int selectHour;
  String errorValidator;
  bool isLoading = false;

  BookTimeState(this.selectHour, this.errorValidator, {this.isLoading = false});

  BookTimeState.fromState(BookTimeState state) {
    this.selectHour = state.selectHour;
    this.errorValidator = state.errorValidator;
    this.isLoading = state.isLoading;
  }

  BookTimeState copyWith(
      {int selectHour, String errorValidator, bool isLoading = false}) {
    return BookTimeState(
        selectHour ?? this.selectHour, errorValidator ?? this.errorValidator,
        isLoading: isLoading ?? this.isLoading);
  }
}

class BookTimeInitial extends BookTimeState {
  BookTimeInitial() : super(0, null);
}

class ChangeTime extends BookTimeState {
  ChangeTime(int selectHour, BookTimeState state)
      : super(selectHour, state.errorValidator);
}

class ChangeErrorText extends BookTimeState {
  ChangeErrorText(String errorText, BookTimeState state)
      : super(state.selectHour, errorText);
}

class SubmitSuccessState extends BookTimeState {
  String message;

  SubmitSuccessState(BookTimeState state, this.message)
      : super.fromState(state);
}
