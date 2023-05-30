import 'package:ambee/data/theme/app_theme.dart';
import 'package:ambee/utils/storage/storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    getThemeFromStorage();
  }

  void changeTheme() {
    if (state.darkTheme) {
      Storage.setTheme(false);
      emit(state.copyWith(darkTheme: false, theme: AppTheme.lightTheme));
    } else {
      Storage.setTheme(true);
      emit(state.copyWith(darkTheme: true, theme: AppTheme.darkTheme));
    }
  }

  void getThemeFromStorage() {
    var isDarkTheme = Storage.getTheme();
    emit(
      state.copyWith(
        darkTheme: isDarkTheme,
        theme: isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
      ),
    );
  }
}
