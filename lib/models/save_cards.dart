import 'package:hive/hive.dart';

part 'save_cards.g.dart';

@HiveType(typeId: 0)
class SaveCards {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String word;

  @HiveField(2)
  final String reading;

  @HiveField(3)
  final String translation;

  @HiveField(4)
  final String? imagePath;

  @HiveField(5)
  final String? article;

  @HiveField(6)
  final String? flag;

  @HiveField(7)
  final int? articleColor;

  @HiveField(8)
  final int? cardBackgroundColor;

  SaveCards({
    required this.id,
    required this.word,
    required this.reading,
    required this.translation,
    this.imagePath,
    this.article,
    this.flag,
    this.articleColor,
    this.cardBackgroundColor,
  });
}
