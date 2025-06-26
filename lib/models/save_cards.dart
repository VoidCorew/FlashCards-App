import 'package:hive/hive.dart';

part 'save_cards.g.dart';

@HiveType(typeId: 0)
class SaveCards {
  @HiveField(0)
  final String word;

  @HiveField(1)
  final String reading;

  @HiveField(2)
  final String translation;

  @HiveField(3)
  final String? imagePath;

  @HiveField(4)
  final String? article;

  @HiveField(5)
  final String? flag;

  @HiveField(6)
  final int? articleColor;

  @HiveField(7)
  final int? cardBackgroundColor;

  SaveCards(
    this.word,
    this.reading,
    this.translation,
    this.imagePath,
    this.article,
    this.flag,
    this.articleColor,
    this.cardBackgroundColor,
  );
}
