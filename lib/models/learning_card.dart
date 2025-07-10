import 'package:flutter/material.dart';

class LearningCard {
  final String id;
  final String? imagePath;
  final String? article;
  final String? flag;
  final Color? articlecolor;
  final String word;
  final String reading;
  final String translation;
  final Color? cardBackgroundColor;

  const LearningCard({
    required this.id,
    this.imagePath,
    this.article,
    this.flag,
    this.articlecolor,
    this.cardBackgroundColor,
    required this.word,
    required this.reading,
    required this.translation,
  });
}
