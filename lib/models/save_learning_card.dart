import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'save_learning_card.g.dart';

@HiveType(typeId: 2)
class LearningCardAdapter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? imagePath;

  @HiveField(2)
  final String? article;

  @HiveField(3)
  final String? flag;

  @HiveField(4)
  final int? articleColorValue;

  @HiveField(5)
  final String word;

  @HiveField(6)
  final String reading;

  @HiveField(7)
  final String translation;

  @HiveField(8)
  final int? cardBackgroundColorValue;

  Color? get articleColor =>
      articleColorValue != null ? Color(articleColorValue!) : null;

  Color? get cardBackgroundColor => cardBackgroundColorValue != null
      ? Color(cardBackgroundColorValue!)
      : null;

  LearningCardAdapter({
    required this.id,
    this.imagePath,
    this.article,
    this.flag,
    Color? articleColor,
    required this.word,
    required this.reading,
    required this.translation,
    Color? cardBackgroundColor,
  }) : articleColorValue = articleColor?.toARGB32(),
       cardBackgroundColorValue = cardBackgroundColor?.toARGB32();
}
