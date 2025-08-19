import 'dart:io';

import 'package:card_learn_languages/models/save_theme.dart';
import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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

  String themeLabel(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.auto:
        return 'Системная';
      case AppThemeMode.dark:
        return 'Темная';
      case AppThemeMode.light:
        return 'Светлая';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final cardProvider = context.watch<CardProvider>();

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
            trailing: IconButton(
              onPressed: () => _pickImage(appProvider),
              icon: Icon(FluentIcons.folder_open_24_regular),
            ),
            title: const Text(
              'Выбрать фон',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
            subtitle: const Text(
              'Выбрать фон приложения',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
          ),

          ListTile(
            trailing: IconButton(
              onPressed: () => appProvider.resetWallpaper(),
              icon: Icon(FluentIcons.arrow_redo_24_regular),
            ),
            title: const Text(
              'Сбросить фон',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
            subtitle: const Text(
              'Сбросить фон приложения',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
          ),

          const Divider(),

          const SizedBox(height: 20),
          const Text(
            'Карточки',
            style: TextStyle(fontFamily: 'wdxl', fontSize: 20),
          ),

          ListTile(
            trailing: IconButton(
              onPressed: () {
                cardProvider.deleteAll();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Все карточки удалены')),
                );
              },
              icon: const Icon(FluentIcons.delete_24_regular),
            ),
            title: const Text('Удалить', style: TextStyle(fontFamily: 'wdxl')),
            subtitle: const Text(
              'Удалить все карточки',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
          ),

          ListTile(
            trailing: IconButton(
              onPressed: () {
                cardProvider.restoreAll();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Все карточки восстановлены')),
                );
              },
              icon: const Icon(FluentIcons.arrow_reset_24_regular),
            ),
            title: const Text(
              'Восстановить',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
            subtitle: const Text(
              'Восстановить все карточки',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
          ),
        ],
      ),
    );
  }
}
