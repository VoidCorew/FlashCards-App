import 'package:hive/hive.dart';

part 'save_card_colors.g.dart';

@HiveType(typeId: 4)
class SaveCardColors {
  @HiveField(0)
  final List<int> recentCardBackgroundColors;

  @HiveField(1)
  final List<int> recentArticleColors;

  SaveCardColors({
    required this.recentArticleColors,
    required this.recentCardBackgroundColors,
  });
}
