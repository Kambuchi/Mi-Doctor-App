abstract class PreferenceRepository {
  bool get isDarkMode;
  Future<void> darkMode(bool enable);
}
