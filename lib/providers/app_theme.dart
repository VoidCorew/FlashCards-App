import 'package:card_learn_languages/models/save_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class AppTheme extends ChangeNotifier {
  static const _boxName = 'app_settings';
  static const _keyIsDark = 'isDark';
  static const _key = 'settings';

  late final Box _settingsBox;

  late bool _isDark;
  bool get isDark => _isDark;

  ThemeMode get currentMode => isDark ? ThemeMode.dark : ThemeMode.light;

  late AppThemeMode _mode;

  AppTheme() {
    _settingsBox = Hive.box<AppSettings>(_boxName);
    final saved = _settingsBox.get(_key);
    _mode = saved?.themeMode ?? AppThemeMode.auto;
    // _isDark = _settingsBox.get(_keyIsDark, defaultValue: false) as bool;
  }

  void toggleTheme() {
    _isDark = !_isDark;
    _settingsBox.put(_keyIsDark, _isDark);
    notifyListeners();
  }
}
