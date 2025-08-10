import 'dart:io';

import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/models/learning_card.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/providers/folders_provider.dart';
import 'package:card_learn_languages/screens/home/cards/create_edit_card.dart';
import 'package:card_learn_languages/screens/quiz/flash_cards_screen.dart';
import 'package:card_learn_languages/screens/quiz/quiz_screen.dart';
import 'package:card_learn_languages/widgets/custom_old_card.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  final _expandableFabKey = GlobalKey<ExpandableFabState>();

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
                : LayoutBuilder(
                    builder: (context, constraints) {
                      // Если ширина экрана < 600 — список
                      if (constraints.maxWidth < 600) {
                        return ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: cards.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomOldCard(
                              card: cards[index],
                              index: index,
                              onAddPressed: () =>
                                  _addToFolderOrRoot(context, index),
                            ),
                          ),
                        );
                      } else {
                        final crossAxisCount = (constraints.maxWidth ~/ 370)
                            .clamp(1, 4); // 300 — желаемая ширина карточки
                        return GridView.builder(
                          padding: EdgeInsets.all(16),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                // maxCrossAxisExtent: 400,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio:
                                    3 / 2, // или подстроить под карточку
                              ),
                          itemCount: cards.length,
                          itemBuilder: (context, index) => CustomOldCard(
                            card: cards[index],
                            index: index,
                            onAddPressed: () =>
                                _addToFolderOrRoot(context, index),
                          ),
                        );
                      }
                    },
                  ),

            // ListView.builder(
            //     padding: EdgeInsets.all(16.0),
            //     itemCount: cards.length,
            //     itemBuilder: (context, index) {
            //       final card = cards[index];
            //       return CustomOldCard(
            //         card: card,
            //         index: index,
            //         onAddPressed: () => _addToFolderOrRoot(context, index),
            //       );
            //     },
            //   ),
          ),
        ],
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _expandableFabKey,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          fabSize: ExpandableFabSize.regular,
          child: const Icon(Icons.menu),
        ),
        closeButtonBuilder: RotateFloatingActionButtonBuilder(
          fabSize: ExpandableFabSize.regular,
          child: const Icon(Icons.close),
        ),
        distance: 150,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.black.withValues(alpha: 0.5),
          blur: 5,
        ),
        children: [
          FloatingActionButton(
            heroTag: 'fab1',
            onPressed: () {
              final state = _expandableFabKey.currentState;
              if (state != null) {
                state.toggle();
              }
            },
            child: Icon(Icons.upload_rounded),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'fab2',
            onPressed: () {
              final state = _expandableFabKey.currentState;
              if (state != null) {
                state.toggle();
              }
            },
            child: Icon(Icons.download_rounded),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'fab3',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FlashCardsScreen(cards: cards),
                ),
              );
              final state = _expandableFabKey.currentState;
              if (state != null) {
                state.toggle();
              }
            },
            child: Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'fab4',
            onPressed: () async {
              final state = _expandableFabKey.currentState;
              if (state != null) {
                state.toggle();
              }

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
        ],
      ),

      // FabCircularMenuPlus(
      //   alignment: Alignment.bottomRight,
      //   ringColor: Colors.green,
      //   ringDiameter: 500.0,
      //   ringWidth: 100.0,
      //   // fabSize: 90.0,
      //   fabElevation: 9.0,
      //   fabIconBorder: CircleBorder(),
      //   fabMargin: const EdgeInsets.all(16.0),
      //   animationDuration: const Duration(milliseconds: 200),
      //   animationCurve: Curves.easeOutQuad,
      //   children: <Widget>[
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: const CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: const Icon(Icons.looks_one, color: Colors.white),
      //     ),
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: const CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: const Icon(Icons.looks_two, color: Colors.white),
      //     ),
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: const CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: const Icon(Icons.looks_3, color: Colors.white),
      //     ),
      //     RawMaterialButton(
      //       onPressed: () {},
      //       shape: const CircleBorder(),
      //       padding: const EdgeInsets.all(24.0),
      //       child: const Icon(Icons.looks_4, color: Colors.white),
      //     ),
      //   ],
      // ),

      // Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       heroTag: 'fab1',
      //       onPressed: () {},
      //       child: Icon(Icons.upload_rounded),
      //     ),
      //     const SizedBox(height: 10),
      //     FloatingActionButton(
      //       heroTag: 'fab2',
      //       onPressed: () {},
      //       child: Icon(Icons.download_rounded),
      //     ),
      //     const SizedBox(height: 10),
      //     FloatingActionButton(
      //       heroTag: 'fab3',
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (_) => FlashCardsScreen(cards: cards),
      //           ),
      //         );
      //       },
      //       child: Icon(Icons.play_arrow),
      //     ),
      //     const SizedBox(height: 10),
      //     FloatingActionButton(
      //       heroTag: 'fab4',
      //       onPressed: () async {
      //         final newCard = await Navigator.push<LearningCard?>(
      //           context,
      //           MaterialPageRoute(builder: (_) => CreateEditCardScreen()),
      //         );

      //         if (newCard != null) {
      //           cardProvider.addCard(newCard);
      //         }
      //       },
      //       child: Icon(Icons.add_rounded),
      //     ),
      //   ],
      // ),
    );
  }

  void _addToFolderOrRoot(BuildContext context, int index) {
    final card = context.read<CardProvider>().cards[index];
    final folderProvider = context.read<FoldersProvider>();

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.folder),
            title: const Text(
              'Добавить в папку',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
            onTap: () {
              Navigator.pop(context);
              _showFolderSelection(context, card);
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Добавить в корень FoldersScreen'),
            onTap: () {
              folderProvider.addCardToRoot(card.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Карточка добавлена в корень экрана "Папки"',
                    style: TextStyle(fontFamily: "wdxl"),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showFolderSelection(BuildContext context, LearningCard card) {
    // final card = context.read<CardProvider>().cards[index];
    final folderProvider = context.read<FoldersProvider>();
    final folders = folderProvider.folders;

    showModalBottomSheet(
      context: context,
      builder: (context) => folders.isEmpty
          ? Center(
              child: const Text(
                'Сначала создайте папку',
                style: TextStyle(fontFamily: "wdxl"),
              ),
            )
          : SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  return ListTile(
                    title: Text(folder.name),
                    onTap: () {
                      folderProvider.addCardToFolder(card.id, folder.id);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Карточка добавлена в ${folder.name}',
                            style: TextStyle(fontFamily: "wdxl"),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
