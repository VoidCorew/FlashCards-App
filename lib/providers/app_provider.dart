import 'package:card_learn_languages/models/save_theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppProvider extends ChangeNotifier {
  static const String _boxName = 'app_settings';
  // late Box<AppSettings> _box;
  // late AppSettings _settings;
  Box<AppSettings>? _box;
  AppSettings? _settings;

  AppSettings get settings => _settings ?? AppSettings();
  String? get wallpaperPath => _settings?.wallpaperPath;
  ThemeMode get themeMode {
    switch (_settings?.themeMode) {
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.auto:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> init() async {
    Hive.registerAdapter(AppThemeModeAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    _box = await Hive.openBox<AppSettings>(_boxName);
    if (_box!.isEmpty) {
      _settings = AppSettings();
      await _box!.put('settings', _settings!);
    } else {
      _settings = _box!.get('settings')!;
    }
  }

  Future<void> setWallpaper(String? path) async {
    _settings!.wallpaperPath = path;
    await _settings!.save();
    notifyListeners();
  }

  Future<void> resetWallpaper() => setWallpaper(null);

  Future<void> setThemeMode(AppThemeMode mode) async {
    _settings!.themeMode = mode;
    await _settings!.save();
    notifyListeners();
  }
}
