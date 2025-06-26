import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppTheme>();

    return Column(
      children: [
        const Text(
          'Выберите вариант',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Слово', style: TextStyle(fontSize: 25)),
                      const Text('➜', style: TextStyle(fontSize: 25)),
                      const Text('Перевод', style: TextStyle(fontSize: 25)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: currentTheme.isDark
                            ? Colors.deepPurple
                            : Colors.indigoAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => QuizScreen(cards: cards),
                        //   ),
                        // );
                      },
                      child: Text(
                        'Начать',
                        style: TextStyle(
                          color: currentTheme.isDark ? null : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Перевод', style: TextStyle(fontSize: 25)),
                      const Text('➜', style: TextStyle(fontSize: 25)),
                      const Text('Слово', style: TextStyle(fontSize: 25)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: currentTheme.isDark
                            ? Colors.deepPurple
                            : Colors.indigoAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Начать',
                        style: TextStyle(
                          color: currentTheme.isDark ? null : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
