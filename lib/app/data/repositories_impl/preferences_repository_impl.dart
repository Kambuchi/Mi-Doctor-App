import '../../domain/repositories/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const darkModeKey = 'dark-mode';

class PreferenceRepositoryImpl implements PreferenceRepository {
  final SharedPreferences _preferences;

  PreferenceRepositoryImpl(this._preferences);

  @override
  bool get isDarkMode => _preferences.getBool(darkModeKey) ?? false;

  @override
  Future<void> darkMode(bool enable) {
    return _preferences.setBool(darkModeKey, enable);
  }
}
