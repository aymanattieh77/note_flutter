import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/controller/theme/theme_cache.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(super.initialState);

  switchTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      ThemeCache().setTheme(true);
    } else {
      emit(ThemeMode.light);
      ThemeCache().setTheme(false);
    }
  }
}
