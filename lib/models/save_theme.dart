import 'package:hive/hive.dart';

part 'save_theme.g.dart';

@HiveType(typeId: 2)
enum AppThemeMode {
  @HiveField(0)
  auto,
  @HiveField(1)
  dark,
  @HiveField(2)
  light,
}

@HiveType(typeId: 3)
class AppSettings extends HiveObject {
  @HiveField(0)
  String? wallpaperPath;

  @HiveField(1)
  AppThemeMode themeMode;

  AppSettings({this.wallpaperPath, this.themeMode = AppThemeMode.auto});
}
