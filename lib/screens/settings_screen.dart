import 'dart:io';

import 'package:card_learn_languages/models/save_theme.dart';
import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    File? _localImage;
    final ImagePicker _picker = ImagePicker();

    Future<void> _pickImage(AppProvider provider) async {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 100,
      );

      if (picked != null) {
        _localImage = File(picked.path);
        await provider.setWallpaper(picked.path);
        setState(() {});
      }
    }

    void resetWallpaper() {
      setState(() {
        _localImage = null;
      });
    }

    final currentTheme = context.watch<AppTheme>();

    final provider = context.watch<AppProvider>();
    final settings = provider.settings;

    String themeLabel(AppThemeMode mode) {
      switch (mode) {
        case AppThemeMode.auto:
          return 'Auto';
        case AppThemeMode.dark:
          return 'Dark';
        case AppThemeMode.light:
          return 'Light';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки', style: TextStyle(fontFamily: 'wdxl')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Основные',
            style: TextStyle(fontFamily: 'wdxl', fontSize: 20),
          ),

          // Theme selection dropdown
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Тема приложения'),
            subtitle: DropdownButton<AppThemeMode>(
              value: settings.themeMode,
              items: AppThemeMode.values.map((mode) {
                return DropdownMenuItem(
                  value: mode,
                  child: Text(themeLabel(mode)),
                );
              }).toList(),
              onChanged: (mode) {
                if (mode != null) provider.setThemeMode(mode);
              },
            ),
          ),

          // Wallpaper picker
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Фон приложения'),
            subtitle: Text(
              settings.wallpaperPath != null ? 'Выбран файл' : 'Нет фона',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.folder_open),
                  onPressed: () => _pickImage(provider),
                ),
                if (settings.wallpaperPath != null)
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      provider.resetWallpaper();
                      setState(() => _localImage = null);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Настройки', style: TextStyle(fontFamily: 'wdxl')),
    //   ),
    //   body: ListView(
    //     padding: const EdgeInsets.all(16),
    //     children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const Text(
    //             'Основные',
    //             style: TextStyle(fontFamily: 'wdxl', fontSize: 20),
    //           ),
    //         ],
    //       ),

    //       ListTile(
    //         leading: const Icon(Icons.wb_sunny),
    //         trailing: IconButton(
    //           onPressed: () => context.read<AppTheme>().toggleTheme(),
    //           icon: Icon(
    //             currentTheme.isDark ? Icons.wb_sunny : Icons.nights_stay,
    //           ),
    //         ),
    //         title: const Text('Тема приложения'),
    //         subtitle: const Text('Выбрать тему приложения'),
    //       ),

    //       ListTile(
    //         leading: const Icon(Icons.photo_library),
    //         trailing: IconButton(
    //           onPressed: pickImage,
    //           icon: Icon(Icons.folder_copy),
    //         ),
    //         title: const Text('Фон приложения'),
    //         subtitle: const Text('Выбрать фон приложения'),
    //       ),

    //       ListTile(
    //         leading: const Icon(Icons.photo_library),
    //         trailing: IconButton(
    //           onPressed: resetWallpaper,
    //           icon: Icon(Icons.refresh),
    //         ),
    //         title: const Text('Фон приложения'),
    //         subtitle: const Text('Сбросить фон приложения'),
    //       ),

    //       const Divider(),

    //       Column(),
    //     ],
    //   ),
    // );
  }
}
