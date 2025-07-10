import 'dart:async';
import 'dart:io';

// import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:card_learn_languages/models/learning_card.dart';
import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:scrumlab_flutter_tindercard/scrumlab_flutter_tindercard.dart';

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

    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() {
        remainingCards.removeAt(previousIndex);
      });
    }
    // setState(() {
    //   remainingCards.removeAt(previousIndex);
    // });

    return true;
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
    CardController controller;
    // final int displayCount = remainingCards.length >= 2 ? 2 : 1;

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
                      style: TextStyle(fontFamily: 'wdxl', color: Colors.black),
                    ),
                    child: Icon(Icons.info),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (remainingCards.isNotEmpty) ...[
                // SizedBox(
                //   height: 500,
                //   width: double.infinity,
                //   child: TinderSwapCard(
                //     orientation: AmassOrientation.bottom,
                //     totalNum: remainingCards.length,
                //     stackNum: 3,
                //     swipeEdge: 4.0,
                //     maxWidth: MediaQuery.of(context).size.width * 0.9,
                //     maxHeight: MediaQuery.of(context).size.width * 0.9,
                //     minWidth: MediaQuery.of(context).size.width * 0.8,
                //     minHeight: MediaQuery.of(context).size.width * 0.8,
                //     cardBuilder: (context, index) {
                //       final card = remainingCards[index];
                //       return _buildSwipeCard(card);
                //     },
                //     cardController: controller = CardController(),
                //     swipeUpdateCallback:
                //         (DragUpdateDetails details, Alignment align) {},
                //     swipeCompleteCallback:
                //         (CardSwipeOrientation orientation, int index) {
                //           final card = remainingCards[index];

                //           if (orientation == CardSwipeOrientation.left) {
                //             stillLearningCards.add(card);
                //           } else if (orientation == CardSwipeOrientation.right) {
                //             learnedCards.add(card);
                //           }

                //           remainingCards.removeAt(index);
                //           setState(() {});
                //         },
                //   ),
                // ),
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
                            // return _buildSwipeCard(card);
                            return Stack(children: [_buildSwipeCard(card)]);
                          },
                      cardsCount: remainingCards.length,
                      isLoop: false,
                      // allowedSwipeDirection: AllowedSwipeDirection.only(
                      //   right: true,
                      //   left: true,
                      //   up: false,
                      //   down: false,
                      // ),
                      numberOfCardsDisplayed: 1,
                      // onSwipe: _onSwipe,
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

    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Flexible(
    //     flex: 1,
    //     child: CardSwiper(
    //       cardsCount: cards.length,
    //       cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
    //           cards[index],
    //     ),
    //   ),
    // );
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

Widget _buildCard(LearningCard card) {
  return Card(
    color: card.cardBackgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
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
