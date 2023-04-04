import 'package:flutter_bloc/flutter_bloc.dart';

class FilterNotesCubit extends Cubit<int> {
  FilterNotesCubit(super.initialState);

  onTabChange(int value) {
    emit(value);
  }
}
