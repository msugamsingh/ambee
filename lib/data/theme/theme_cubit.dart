import 'package:ambee/utils/storage/storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState()) {
    getThemeFromStorage();
  }

  void changeTheme() {
    print(state.darkTheme);
    if (state.darkTheme) {
      Storage.setTheme(false);
      emit(state.copyWith(darkTheme: false));
    } else {
      Storage.setTheme(true);
      emit(state.copyWith(darkTheme: true));
    }
  }

  void getThemeFromStorage() {
    emit(state.copyWith(darkTheme: Storage.getTheme()));
  }
}
