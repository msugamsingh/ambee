import 'package:ambee/app/user/model/user.dart';
import 'package:get_storage/get_storage.dart';

class Storage {
  Storage._privateConstructor();

  static final _box = GetStorage();

  static void setTheme(bool? darkTheme) {
    _box.write(StorageKeys.DARK_THEME, darkTheme ?? true);
  }

  static bool getTheme() => _box.read(StorageKeys.DARK_THEME) ?? true;

  static void setUser(User user) =>
      _box.write(StorageKeys.USER_DETAILS, user.toJson());

  static User? getUser() {
    final json = _box.read(StorageKeys.USER_DETAILS);
    if (json != null) {
      return User.fromJson(json);
    } else {
      return null;
    }
  }

}

class StorageKeys {
  static const DARK_THEME = 'dark_theme';
  static const USER_DETAILS = 'user_details';
}
