import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());
}
