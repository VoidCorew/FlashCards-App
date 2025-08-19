import 'dart:io';

import 'package:card_learn_languages/models/learning_card.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class QuizScreen extends StatefulWidget {
  final List<LearningCard> cards;
  const QuizScreen({super.key, required this.cards});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<LearningCard> remainingCards;
  final List<LearningCard> stillLearningCards = [];
  final List<LearningCard> learnedCards = [];

  final CardSwiperController cardSwiperController = CardSwiperController();

  final List<Color> cardsColors = [
    Colors.amber,
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.indigo,
    Colors.orange,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    remainingCards = List.of(widget.cards);
  }

  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: const Text('1'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: const Text('2'),
    ),
    Container(
      alignment: Alignment.center,
      color: Colors.purple,
      child: const Text('3'),
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    cardSwiperController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${stillLearningCards.length} Карточек "Еще учу"',
                        style: TextStyle(
                          fontFamily: 'wdxl',
                          fontSize: 20,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        '${learnedCards.length} Карточек "Выучено"',
                        style: TextStyle(
                          fontFamily: 'wdxl',
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  ElTooltip(
                    content: Text(
                      'Свайпните вправо, чтобы пометить слово как "Выученное", свайпните влево, чтобы пометить слово как "Еще учу"',
                      style: TextStyle(fontFamily: 'wdxl', color: Colors.black),
                    ),
                    child: Icon(Icons.info),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (remainingCards.isNotEmpty) ...[
                SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Flexible(
                    child: CardSwiper(
                      controller: cardSwiperController,
                      backCardOffset: const Offset(0, 0),
                      padding: const EdgeInsets.all(24.0),
                      cardBuilder:
                          (
                            context,
                            index,
                            percentThresholdX,
                            percentThresholdY,
                          ) {
                            final card = remainingCards[index];
                            return Stack(children: [_buildSwipeCard(card)]);
                          },
                      cardsCount: remainingCards.length,
                      isLoop: false,
                      numberOfCardsDisplayed: 1,
                    ),
                  ),
                ),
              ] else ...[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      remainingCards = List.of(widget.cards);
                      learnedCards.clear();
                      stillLearningCards.clear();
                    });
                  },
                  child: const Text('Начать еще раз'),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Выйти в меню'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSwipeCard(LearningCard card) {
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
