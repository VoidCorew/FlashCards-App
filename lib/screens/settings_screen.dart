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

  void resetWallpaper(AppProvider provider) {
    provider.resetWallpaper();
    setState(() {
      _localImage = null;
    });
  }

  // void resetWallpaper() {
  //   setState(() {
  //     _localImage = null;
  //   });
  // }

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

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppTheme>();
    final provider = context.watch<AppProvider>();
    final settings = provider.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки', style: TextStyle(fontFamily: 'wdxl')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Основные',
                style: TextStyle(fontFamily: 'wdxl', fontSize: 20),
              ),
            ],
          ),

          ListTile(
            leading: const Icon(Icons.wb_sunny),
            trailing: IconButton(
              onPressed: () => context.read<AppTheme>().toggleTheme(),
              icon: Icon(
                currentTheme.isDark ? Icons.wb_sunny : Icons.nights_stay,
              ),
            ),
            title: const Text('Тема приложения'),
            subtitle: const Text('Выбрать тему приложения'),
          ),

          ListTile(
            leading: const Icon(Icons.photo_library),
            trailing: IconButton(
              onPressed: () => _pickImage(provider),
              icon: Icon(Icons.folder_copy),
            ),
            title: const Text('Выбрать фон'),
            subtitle: const Text('Выбрать фон приложения'),
          ),

          ListTile(
            leading: const Icon(Icons.photo_library),
            trailing: IconButton(
              onPressed: () => resetWallpaper(provider),
              icon: Icon(Icons.refresh),
            ),
            title: const Text('Сбросить фон'),
            subtitle: const Text('Сбросить фон приложения'),
          ),

          const Divider(),

          Column(),
        ],
      ),
    );
  }
}
