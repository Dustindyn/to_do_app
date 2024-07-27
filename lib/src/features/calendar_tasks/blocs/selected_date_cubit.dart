import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedDateCubit extends Cubit<DateTime> {
  SelectedDateCubit(super.initialState);

  void selectDate(DateTime newDate) {
    emit(newDate);
  }
}
