import 'dart:io';

import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/models/learning_card.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/screens/home/cards/create_edit_card.dart';
import 'package:card_learn_languages/widgets/custom_old_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  Widget build(BuildContext context) {
    // final currentTheme = context.watch<AppTheme>();
    // final theme = Theme.of(context);
    // final colors = theme.colorScheme;

    // ------------------- Provider Storage Added -------------------
    // final provider = context.watch<CardProvider>();
    // final cards = provider.cards;

    // ------------------- App Provider Added -------------------
    final appProvider = context.watch<AppProvider>();
    final cardProvider = context.watch<CardProvider>();
    final cards = cardProvider.cards;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (appProvider.wallpaperPath != null)
            Image.file(File(appProvider.wallpaperPath!), fit: BoxFit.cover),
          SafeArea(
            child: cards.isEmpty
                ? Center(
                    child: const Text(
                      'У вас пока нет карточек',
                      style: TextStyle(fontFamily: 'wdxl'),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return CustomOldCard(card: card, index: index);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCard = await Navigator.push<LearningCard?>(
            context,
            MaterialPageRoute(builder: (_) => CreateEditCardScreen()),
          );

          if (newCard != null) {
            cardProvider.addCard(newCard);
          }
        },
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
