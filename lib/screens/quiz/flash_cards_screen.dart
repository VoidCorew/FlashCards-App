import 'dart:io';

import 'package:card_learn_languages/models/learning_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class FlashCardsScreen extends StatefulWidget {
  final List<LearningCard> cards;
  const FlashCardsScreen({super.key, required this.cards});

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen> {
  late List<LearningCard> _remaining;
  final List<LearningCard> _learned = [];
  final List<LearningCard> _stillLearning = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _remaining = List.from(widget.cards);
  }

  void _markLearned() {
    setState(() {
      final card = _remaining[_currentIndex];
      _learned.add(card);
      _advance();
    });
  }

  void _markStillLearning() {
    setState(() {
      final card = _remaining[_currentIndex];
      _stillLearning.add(card);
      _advance();
    });
  }

  void _advance() {
    _currentIndex++;
    if (_currentIndex >= _remaining.length) {
      _showCompletedDialog();
    }
  }

  void _showCompletedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Викторина завершена',
          style: TextStyle(fontFamily: 'wdxl'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Выучено: ${_learned.length}',
              style: TextStyle(fontFamily: 'wdxl', fontSize: 18),
            ),
            Text(
              'Ещё учу: ${_stillLearning.length}',
              style: TextStyle(fontFamily: 'wdxl', fontSize: 18),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text(
                  'Выйти',
                  style: TextStyle(fontFamily: 'wdxl'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _restart();
                },
                child: const Text(
                  'Начать снова',
                  style: TextStyle(fontFamily: 'wdxl'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _restart() {
    setState(() {
      _resetCards();
    });
  }

  void _resetCards() {
    _remaining = List.of(widget.cards);
    _learned.clear();
    _stillLearning.clear();
    _currentIndex = 0;
  }

  final controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    final hasCard = _currentIndex < _remaining.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Флеш-карты')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Еще учу: ${_stillLearning.length}',
                    style: TextStyle(
                      fontFamily: 'wdxl',
                      fontSize: 20,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    'Выучено: ${_learned.length}',
                    style: TextStyle(
                      fontFamily: 'wdxl',
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: hasCard
                      ? _buildCard(_remaining[_currentIndex])
                      : const Text(
                          'У вас нет карточек',
                          style: TextStyle(fontSize: 25, fontFamily: 'wdxl'),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              if (hasCard) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _markLearned,
                      child: const Text(
                        'Выучено',
                        style: TextStyle(fontSize: 25, fontFamily: 'wdxl'),
                      ),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _markStillLearning,
                      child: const Text(
                        'Ещё учу',
                        style: TextStyle(fontSize: 25, fontFamily: 'wdxl'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildCard(LearningCard card) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(
  //           color: Theme.of(context).brightness == Brightness.dark
  //               ? Colors.white
  //               : Colors.black,
  //           // spreadRadius: 2,
  //           blurRadius: 10,
  //           offset: Offset(0, 0),
  //         ),
  //       ],
  //     ),
  //     child: Card(
  //       // elevation: 4,
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             if (card.imagePath != null) ...[
  //               Image.file(
  //                 File(card.imagePath!),
  //                 width: 100,
  //                 height: 100,
  //                 fit: BoxFit.cover,
  //               ),
  //               const SizedBox(height: 12),
  //             ],
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 if (card.article != null)
  //                   Text(
  //                     card.article!,
  //                     style: TextStyle(
  //                       fontSize: 24,
  //                       color: card.articlecolor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 const SizedBox(width: 8),
  //                 Text(card.word, style: const TextStyle(fontSize: 32)),
  //               ],
  //             ),
  //             const SizedBox(height: 12),
  //             Text(card.reading, style: const TextStyle(fontSize: 20)),
  //             const SizedBox(height: 8),
  //             Text(card.translation, style: const TextStyle(fontSize: 18)),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCard(LearningCard card) {
    return FlipCard(
      onTapFlipping: true,
      frontWidget: Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              // spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Card(
          // elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                if (card.imagePath != null) ...[
                  Image.file(
                    File(card.imagePath!),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (card.article != null)
                      Text(
                        card.article!,
                        style: TextStyle(
                          fontSize: 24,
                          color: card.articlecolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(card.word, style: const TextStyle(fontSize: 32)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(card.reading, style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
      backWidget: Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              // spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(card.translation, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
      controller: controller,
      rotateSide: RotateSide.bottom,
    );
  }
}
