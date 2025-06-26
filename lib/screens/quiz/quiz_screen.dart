import 'dart:async';

// import 'package:appinio_swiper/appinio_swiper.dart';
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
    // _swiperController = AppinioSwiperController(); // +ADDED APPINIO
    remainingCards = List.of(widget.cards);
  }

  FutureOr<bool> _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    if (previousIndex < 0 || previousIndex >= remainingCards.length) {
      return false;
    }
    final card = remainingCards[previousIndex];

    if (direction == CardSwiperDirection.right) {
      learnedCards.add(card);
    } else if (direction == CardSwiperDirection.left) {
      stillLearningCards.add(card);
    }

    // Future.delayed(const Duration(milliseconds: 300), () {
    //   if (mounted) {
    //     setState(() {
    //       remainingCards.removeAt(previousIndex);
    //     });
    //   }
    // });
    setState(() {
      // remainingCards.removeAt(index);
      remainingCards.remove(card);
    });

    return true;
  }

  // ------------------ APPINIO ------------------
  // late final AppinioSwiperController _swiperController;

  @override
  Widget build(BuildContext context) {
    final int displayCount = remainingCards.length >= 2 ? 2 : 1;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                      style: TextStyle(fontSize: 20, color: Colors.amber),
                    ),
                    Text(
                      '${learnedCards.length} Карточек "Выучено"',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                  ],
                ),

                // IconButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (_) => AlertDialog(
                //         content: const Text(
                //           'Свайпните вправо, чтобы пометить слово как "Выученное", свайпните влево, чтобы пометить слово как "Еще учу"',
                //         ),
                //       ),
                //     );
                //   },
                //   icon: Icon(Icons.info),
                // ),
                ElTooltip(
                  content: Text(
                    'Свайпните вправо, чтобы пометить слово как "Выученное", свайпните влево, чтобы пометить слово как "Еще учу"',
                    style: TextStyle(color: Colors.black),
                  ),
                  child: Icon(Icons.info),
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (remainingCards.isNotEmpty) ...[
              Expanded(
                child: CardSwiper(
                  cardBuilder:
                      (context, index, percentThresholdX, percentThresholdY) {
                        final card = remainingCards[index];
                        return _buildCard(card);
                      },
                  cardsCount: remainingCards.length,
                  isLoop: false,
                  allowedSwipeDirection: AllowedSwipeDirection.only(
                    right: true,
                    left: true,
                    up: false,
                    down: false,
                  ),
                  numberOfCardsDisplayed: displayCount,
                  onSwipe: _onSwipe,
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
    );
  }
}

Widget _buildCard(LearningCard card) {
  return SizedBox(
    width: double.infinity,
    height: 500,
    child: Card(
      color: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(card.word, style: TextStyle(fontSize: 25, color: Colors.black)),
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
