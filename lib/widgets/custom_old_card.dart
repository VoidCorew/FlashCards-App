import 'dart:io';

import 'package:card_learn_languages/models/learning_card.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/screens/home/cards/create_edit_card.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomOldCard extends StatelessWidget {
  final LearningCard card;
  final int index;
  final VoidCallback onAddPressed;
  const CustomOldCard({
    super.key,
    required this.card,
    required this.index,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardProvider = context.read<CardProvider>();

    return Card(
      color: card.cardBackgroundColor,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // -------------------- Card Image --------------------
              if (card.imagePath != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.file(File(card.imagePath!), fit: BoxFit.cover),
                    // child:
                    //     card.imagePath != null &&
                    //         File(card.imagePath!).existsSync()
                    //     ? Image.file(File(card.imagePath!), fit: BoxFit.cover)
                    //     : Image.asset('assets/images/default_card_image.jpg'),
                  ),
                ),
                const SizedBox(width: 15),
              ],

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------------------ Card Icons ------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(card.flag ?? ''),

                        Row(
                          children: [
                            // IconButton(
                            //   onPressed: () {},
                            //   icon: Icon(FluentIcons.add_24_filled),
                            // ),
                            IconButton(
                              onPressed: () async {
                                final updatedCard = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CreateEditCardScreen(card: card),
                                  ),
                                );

                                if (updatedCard != null) {
                                  cardProvider.updatedCard(index, updatedCard);
                                }
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              // onPressed: () => deleteCard(card),
                              onPressed: () => cardProvider.deleteCard(index),
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // const SizedBox(height: 3),

                    // ------------------------------ Card Words ------------------------------
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          card.article ?? '',
                          style: TextStyle(
                            fontSize: 25,
                            color:
                                card.articlecolor ??
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),

                        const SizedBox(width: 15),

                        Text(card.word, style: theme.textTheme.headlineLarge),

                        // const VerticalDivider(
                        //   width: 20,
                        //   thickness: 1,
                        //   indent: 20,
                        //   endIndent: 0,
                        //   color: Colors.white,
                        // ),
                        // Expanded(
                        //   child: Padding(
                        //     padding: EdgeInsetsGeometry.only(
                        //       left: 20,
                        //       right: 10,
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Text(
                        //           card.word,
                        //           style: theme.textTheme.headlineLarge,
                        //         ),

                        //         const SizedBox(width: 10),

                        //         Text(
                        //           card.reading,
                        //           style: theme.textTheme.labelMedium?.copyWith(
                        //             fontStyle: FontStyle.italic,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            card.reading,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Divider(),

                    const SizedBox(height: 10),

                    Text(
                      card.translation,
                      // style: theme.textTheme.labelLarge?.copyWith(
                      //   fontWeight: FontWeight.w500,
                      // ),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
