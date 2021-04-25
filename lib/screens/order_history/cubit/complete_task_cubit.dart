import 'package:flutter_map_booking/common/base_cubit.dart';

part 'complete_task_state.dart';

class CompleteTaskCubit extends BaseCubit<CompleteTaskState> {
  CompleteTaskCubit() : super(CompleteTaskInitial());

  @override
  initData() {}

  selectTips(int index) {
    emit(CompleteTaskSelectTip(index, state));
  }

  selectRateStar(int index) {
    emit(CompleteTaskSelectRateStar(state, index));
  }
}
