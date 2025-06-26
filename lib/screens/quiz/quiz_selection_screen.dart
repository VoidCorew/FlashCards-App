import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/screens/quiz/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizSelectionScreen extends StatelessWidget {
  const QuizSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final currentTheme = context.watch<AppTheme>();
    final cards = context.watch<CardProvider>().cards;

    return Scaffold(
      // appBar: AppBar(title: const Text('Викторина')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Text(
              'Выберите вариант',
              style: TextStyle(
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
                  color: currentTheme.isDark ? Colors.white : Colors.black,
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
                title: const Text('Флеш-карты', style: TextStyle(fontSize: 20)),
                leading: const Icon(Icons.book),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
