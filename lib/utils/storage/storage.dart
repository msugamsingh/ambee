import 'package:get_storage/get_storage.dart';

class Storage {
  Storage._privateConstructor();

  static final _box = GetStorage();

  static void setTheme(bool? darkTheme) {
    _box.write(StorageKeys.DARK_THEME, darkTheme ?? true);
  }

  static bool getTheme() => _box.read(StorageKeys.DARK_THEME) ?? true;
}

class StorageKeys {
  static const DARK_THEME = 'dark_theme';
}