import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/model/schedule_service_request.dart';
import 'package:flutter_map_booking/model/send_request.dart';

part 'book_time_state.dart';

class BookTimeCubit extends BaseCubit<BookTimeState> {
  BookTimeCubit() : super(BookTimeInitial());

  @override
  initData() {
    emit(BookTimeInitial());
  }

  changeTime(int index) {
    emit(ChangeTime(index, state));
  }

  changeErrorText(String text) {
    emit(ChangeErrorText(text ?? null, state));
  }

  submitSchedule({DateTime pickTime, pickDateTime, SendRequest sendRequest}) {
    ScheduleRequest scheduleRequest = ScheduleRequest()
      ..pickDate = pickDateTime
      ..pickTime = pickTime;
    sendScheduleRequest(
      sendRequest: sendRequest,
      scheduleRequest: scheduleRequest,
    );
  }

  sendScheduleRequest(
      {SendRequest sendRequest, ScheduleRequest scheduleRequest}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final time = hourHMFormatter.format(scheduleRequest.pickTime);
      final date = dateFormatter.format(scheduleRequest.pickDate);
      sendRequest.scheduleTime = time;
      sendRequest.scheduleDate = date;
      final response = await dataRepository.sendRequest(sendRequest);
      emit(SubmitSuccessState(state, response.message));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      handleAppError(e);
    }
  }
}
