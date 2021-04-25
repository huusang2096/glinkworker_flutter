part of 'complete_task_cubit.dart';

class CompleteTaskState {
  int tips;
  int rateStar;

  CompleteTaskState(this.tips, this.rateStar);
}

class CompleteTaskInitial extends CompleteTaskState {
  CompleteTaskInitial() : super(0, 1);
}

class CompleteTaskSelectRateStar extends CompleteTaskState {
  CompleteTaskSelectRateStar(CompleteTaskState state, int rateStar)
      : super(state.tips, rateStar);
}

class CompleteTaskSelectTip extends CompleteTaskState {
  CompleteTaskSelectTip(int tips, CompleteTaskState state)
      : super(tips, state.rateStar);
}
