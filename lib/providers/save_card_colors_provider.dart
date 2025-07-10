import 'package:card_learn_languages/models/save_card_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SaveCardColorsProvider extends ChangeNotifier {
  static const String boxName = 'save_card_colors';
  late Box<SaveCardColors> _box;

  List<Color> _articleColors = [];
  List<Color> _cardBackgroundColors = [];

  List<Color> get articleColors => List.unmodifiable(_articleColors);
  List<Color> get cardBackgroundColors =>
      List.unmodifiable(_cardBackgroundColors);

  SaveCardColorsProvider() {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox(boxName);
    final settings = _box.get('colors');
    if (settings != null) {
      _articleColors = settings.recentArticleColors
          .map((e) => Color(e))
          .toList();
      _cardBackgroundColors = settings.recentCardBackgroundColors
          .map((e) => Color(e))
          .toList();
    }
  }

  Future<void> _save() async {
    await _box.put(
      'colors',
      SaveCardColors(
        recentArticleColors: _articleColors.map((e) => e.toARGB32()).toList(),
        recentCardBackgroundColors: _cardBackgroundColors
            .map((e) => e.toARGB32())
            .toList(),
      ),
    );
  }

  void addArtileColor(Color color) {
    _articleColors.remove(color);
    _articleColors.insert(0, color);
    if (_articleColors.length > 5) _articleColors.removeLast();
    _save();
    notifyListeners();
  }

  void addCardBackgroundColor(Color color) {
    _cardBackgroundColors.remove(color);
    _cardBackgroundColors.insert(0, color);
    if (_cardBackgroundColors.length > 5) _cardBackgroundColors.removeLast();
    _save();
    notifyListeners();
  }
}
