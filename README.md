# card_learn_languages

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This is my App Colors
```dart
import 'package:flutter/material.dart';

/// Define a centralized color palette for light and dark modes.
class AppColors {
  // Light theme colors
  static const Color lightPrimary = Color(0xFF4CAF50);       // Green
  static const Color lightPrimaryVariant = Color(0xFF388E3C);
  static const Color lightSecondary = Color(0xFFFFC107);     // Amber
  static const Color lightSecondaryVariant = Color(0xFFFFA000);
  static const Color lightBackground = Color(0xFFF1F8E9);    // Light green background
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFD32F2F);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFF000000);
  static const Color lightOnBackground = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightOnError = Color(0xFFFFFFFF);

  // Dark theme colors
  static const Color darkPrimary = Color(0xFF81C784);        // Light green
  static const Color darkPrimaryVariant = Color(0xFF519657);
  static const Color darkSecondary = Color(0xFFFFD54F);      // Soft amber
  static const Color darkSecondaryVariant = Color(0xFFFFC028);
  static const Color darkBackground = Color(0xFF1B5E20);     // Dark green
  static const Color darkSurface = Color(0xFF2E7D32);
  static const Color darkError = Color(0xFFEF5350);
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnError = Color(0xFF000000);
}

/// Generates light ThemeData
ThemeData buildLightTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.lightPrimary,
      primaryVariant: AppColors.lightPrimaryVariant,
      secondary: AppColors.lightSecondary,
      secondaryVariant: AppColors.lightSecondaryVariant,
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      error: AppColors.lightError,
      onPrimary: AppColors.lightOnPrimary,
      onSecondary: AppColors.lightOnSecondary,
      onBackground: AppColors.lightOnBackground,
      onSurface: AppColors.lightOnSurface,
      onError: AppColors.lightOnError,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.lightOnPrimary,
        backgroundColor: AppColors.lightPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.lightPrimary,
      ),
    ),
  );
}

/// Generates dark ThemeData
ThemeData buildDarkTheme() {
  final base = ThemeData.dark();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.darkPrimary,
      primaryVariant: AppColors.darkPrimaryVariant,
      secondary: AppColors.darkSecondary,
      secondaryVariant: AppColors.darkSecondaryVariant,
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      error: AppColors.darkError,
      onPrimary: AppColors.darkOnPrimary,
      onSecondary: AppColors.darkOnSecondary,
      onBackground: AppColors.darkOnBackground,
      onSurface: AppColors.darkOnSurface,
      onError: AppColors.darkOnError,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.darkOnPrimary,
        backgroundColor: AppColors.darkPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: AppColors.darkSecondary,
      ),
    ),
  );
}
```

home_screen.dart
```dart
  // ----------------- Local Storage Removed -----------------

  // final List<LearningCard> cards = [];
  // late final Box<SaveCards> _cardsBox;

  // @override
  // void initState() {
  //   super.initState();
  //   _cardsBox = Hive.box<SaveCards>('save_cards');
  //   for (var saved in _cardsBox.values) {
  //     cards.add(
  //       LearningCard(
  //         word: saved.word,
  //         reading: saved.reading,
  //         translation: saved.translation,
  //       ),
  //     );
  //   }
  // }

  // void _addNewCard(LearningCard newCard) {
  //   setState(() {
  //     cards.add(newCard);
  //   });
  //   _cardsBox.add(
  //     SaveCards(newCard.word, newCard.reading, newCard.translation),
  //   );
  // }

  // void _updateCard(int index, LearningCard updatedCard) {
  //   setState(() {
  //     cards[index] = updatedCard;
  //   });
  //   _cardsBox.putAt(
  //     index,
  //     SaveCards(updatedCard.word, updatedCard.reading, updatedCard.translation),
  //   );
  // }

  // void deleteCard(LearningCard card) {
  //   final index = cards.indexOf(card);
  //   setState(() {
  //     cards.remove(card);
  //   });
  //   _cardsBox.deleteAt(index);
  // }

  // ----------- This is trash -----------
  // void _openCardEditor(LearningCard card, int index) async {
  //   final updatedCard =
  //       await Navigator.pushNamed(
  //             context,
  //             '/card_details',
  //             arguments: {'card': card, 'index': index},
  //           )
  //           as LearningCard?;

  //   if (updatedCard != null) {
  //     setState(() {
  //       cards[index] = updatedCard;
  //     });
  //   }
  // }
```

old appbar
```dart
// appBar: AppBar(
      //   title: const Text('Мои карточки', style: TextStyle(fontFamily: 'wdxl')),
      //   actions: [
      //     IconButton(
      //       onPressed: () => context.read<AppTheme>().toggleTheme(),
      //       icon: Icon(
      //         currentTheme.isDark ? Icons.wb_sunny : Icons.nights_stay,
      //       ),
      //     ),
      //     IconButton(onPressed: _pickImage, icon: Icon(Icons.photo_library)),
      //     IconButton(onPressed: _resetWallpaper, icon: Icon(Icons.refresh)),
      //     IconButton(
      //       onPressed: () {
      //         showDialog<void>(
      //           context: context,
      //           barrierDismissible: false,
      //           builder: (context) => AlertDialog(
      //             title: const Text('Удалить все карточки'),
      //             content: Text(
      //               'Вы действительно хотите удалить все карточки?',
      //             ),
      //             actions: [
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   TextButton(
      //                     onPressed: () {
      //                       Navigator.pop(context);
      //                     },
      //                     child: const Text('Нет'),
      //                   ),
      //                   TextButton(
      //                     onPressed: () {
      //                       provider.deleteAll();
      //                       Navigator.pop(context);
      //                     },
      //                     child: const Text('Да'),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //       icon: Icon(Icons.delete_forever),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         provider.restoreAll();
      //       },
      //       icon: Icon(Icons.restore),
      //     ),
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => SettingsScreen()),
      //         );
      //       },
      //       icon: Icon(Icons.settings),
      //     ),
      //   ],
      // ),
```

old appbar picker
```dart
  // File? _imageFile;
  // final ImagePicker _picker = ImagePicker();

  // Future<void> _pickImage() async {
  //   final XFile? picked = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1920,
  //     maxHeight: 1080,
  //     imageQuality: 100,
  //   );

  //   if (picked != null) {
  //     setState(() {
  //       _imageFile = File(picked.path);
  //     });
  //   }
  // }

  // void _resetWallpaper() {
  //   setState(() {
  //     _imageFile = null;
  //   });
  // }
```

old settings
```dart
// return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Настройки', style: TextStyle(fontFamily: 'wdxl')),
    //   ),
    //   body: ListView(
    //     padding: const EdgeInsets.all(16),
    //     children: [
    //       const Text(
    //         'Основные',
    //         style: TextStyle(fontFamily: 'wdxl', fontSize: 20),
    //       ),

    //       // Theme selection dropdown
    //       ListTile(
    //         leading: const Icon(Icons.palette),
    //         title: const Text('Тема приложения'),
    //         subtitle: DropdownButton<AppThemeMode>(
    //           value: settings.themeMode,
    //           items: AppThemeMode.values.map((mode) {
    //             return DropdownMenuItem(
    //               value: mode,
    //               child: Text(themeLabel(mode)),
    //             );
    //           }).toList(),
    //           onChanged: (mode) {
    //             if (mode != null) provider.setThemeMode(mode);
    //           },
    //         ),
    //       ),

    //       // Wallpaper picker
    //       ListTile(
    //         leading: const Icon(Icons.photo_library),
    //         title: const Text('Фон приложения'),
    //         subtitle: Text(
    //           settings.wallpaperPath != null ? 'Выбран файл' : 'Нет фона',
    //         ),
    //         trailing: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             IconButton(
    //               icon: const Icon(Icons.folder_open),
    //               onPressed: () => _pickImage(provider),
    //             ),
    //             if (settings.wallpaperPath != null)
    //               IconButton(
    //                 icon: const Icon(Icons.refresh),
    //                 onPressed: () {
    //                   provider.resetWallpaper();
    //                   setState(() => _localImage = null);
    //                 },
    //               ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
```