import 'package:card_learn_languages/models/save_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppProvider extends ChangeNotifier {
  static const String _boxName = 'app_settings';
  static const String _settingsKey = 'settings';

  late Box<AppSettings> _box;
  late AppSettings _settings;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  AppProvider() {
    _init();
  }

  Future<void> _init() async {
    _box = Hive.box<AppSettings>(_boxName);
    final existing = _box.get(_settingsKey);

    if (existing == null) {
      _settings = AppSettings();
      _box.put(_settingsKey, _settings);
    } else {
      _settings = existing;
    }

    _isInitialized = true;
    notifyListeners();
  }

  AppSettings get settings => _settings;
  String? get wallpaperPath => _settings.wallpaperPath;

  ThemeMode get themeMode {
    switch (_settings.themeMode) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.auto:
        return ThemeMode.system;
    }
  }

  Future<void> setWallpaper(String? path) async {
    _settings.wallpaperPath = path;
    await _settings.save();
    notifyListeners();
  }

  Future<void> resetWallpaper() async {
    await setWallpaper(null);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    _settings.themeMode = mode;
    await _settings.save();
    notifyListeners();
  }

  bool get isDark => _settings.themeMode == AppThemeMode.dark;

  Future<void> toggleTheme() async {
    if (_settings.themeMode == AppThemeMode.dark) {
      _settings.themeMode = AppThemeMode.light;
    } else {
      _settings.themeMode = AppThemeMode.dark;
    }
    await _settings.save();
    notifyListeners();
  }
}
