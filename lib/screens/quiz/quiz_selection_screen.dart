import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/screens/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizSelectionScreen extends StatelessWidget {
  const QuizSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = context.watch<CardProvider>().cards;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Text(
              'Выберите вариант',
              style: TextStyle(
                fontFamily: 'wdxl',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  width: 1.5,
                ),
              ),
              child: ListTile(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(cards: cards),
                  ),
                ),
                title: const Text(
                  'Флеш-карты',
                  style: TextStyle(fontFamily: 'wdxl', fontSize: 20),
                ),
                leading: const Icon(Icons.book),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
