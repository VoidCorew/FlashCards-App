import 'dart:io';

import 'package:card_learn_languages/models/learning_card.dart';
import 'package:flutter/material.dart';

class SwipeCard extends StatelessWidget {
  final LearningCard card;
  final VoidCallback? onLike;
  final VoidCallback? onNope;
  const SwipeCard({
    super.key,
    required this.card,
    required this.onLike,
    required this.onNope,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: card.cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              child: card.imagePath != null
                  ? Image.file(
                      height: 100,
                      width: 100,
                      File(card.imagePath!),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      height: 100,
                      width: 100,
                      'assets/images/default_card_image.jpg',
                      fit: BoxFit.cover,
                    ),
            ),

            const Divider(thickness: 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  card.article ?? '',
                  style: TextStyle(
                    fontFamily: 'wdxl',
                    fontSize: 25,
                    color: card.articlecolor,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  card.word,
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              card.reading,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Text(
              card.translation,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
