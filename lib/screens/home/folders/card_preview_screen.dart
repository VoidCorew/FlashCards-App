import 'package:card_learn_languages/models/learning_card.dart';
import 'package:card_learn_languages/widgets/custom_old_card.dart';
import 'package:flutter/material.dart';

class CardPreviewScreen extends StatelessWidget {
  final LearningCard card;
  const CardPreviewScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Слово карточки: ${card.word}')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 210,
            child: CustomOldCard(card: card, index: 0, onAddPressed: () {}),
          ),
        ),
      ),
    );
  }
}
