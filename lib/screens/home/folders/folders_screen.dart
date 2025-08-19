import 'dart:io';

import 'package:card_learn_languages/models/learning_card.dart';
import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/providers/folders_provider.dart';
import 'package:card_learn_languages/screens/home/folders/card_preview_screen.dart';
import 'package:card_learn_languages/screens/home/folders/folder_cards_screen.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final folderProvider = context.watch<FoldersProvider>();
    final folders = folderProvider.folders;
    final rootCards = folderProvider.rootCards;
    final cardProvider = context.watch<CardProvider>();
    final appProvider = context.watch<AppProvider>();

    return Stack(
      fit: StackFit.expand,
      children: [
        if (appProvider.wallpaperPath != null)
          Image.file(File(appProvider.wallpaperPath!), fit: BoxFit.cover),

        Scaffold(
          body: ListView(
            children: [
              if (rootCards.isNotEmpty)
                ExpansionTile(
                  leading: const Icon(FluentIcons.card_ui_24_regular),
                  title: Text(
                    "Карточки в корне",
                    style: TextStyle(fontFamily: 'wdxl'),
                  ),
                  children: rootCards.map((cardId) {
                    final card = cardProvider.getCardById(cardId);
                    return ListTile(
                      onTap: () {
                        if (card != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CardPreviewScreen(card: card),
                            ),
                          );
                        }
                      },
                      leading: const Icon(
                        FluentIcons.card_ui_portrait_flip_24_regular,
                      ),
                      title: Text(
                        card?.word ?? "Удаленная карточка",
                        style: TextStyle(fontFamily: 'wdxl'),
                      ),
                      trailing: IconButton(
                        onPressed: () =>
                            folderProvider.removeCardFromRoot(cardId),
                        icon: Icon(Icons.remove),
                      ),
                    );
                  }).toList(),
                ),

              ...folders.map(
                (folder) => ListTile(
                  leading: const Icon(Icons.folder),
                  title: Text(folder.name),
                  titleTextStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'wdxl',
                    fontSize: 20,
                  ),
                  trailing: IconButton(
                    onPressed: () => folderProvider.deleteFolder(folder.id),
                    icon: const Icon(Icons.delete),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FolderCardsScreen(folderId: folder.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: SpeedDial(
            spacing: 5,
            curve: Curves.bounceIn,
            activeIcon: Icons.close,
            children: [
              SpeedDialChild(
                elevation: 0,
                child: Icon(FluentIcons.card_ui_24_regular),
                labelWidget: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: const Text(
                    'Добавить карточку',
                    style: TextStyle(fontFamily: 'wdxl'),
                  ),
                ),
                onTap: () => _addCardToRootOrFolder(context),
              ),
              SpeedDialChild(
                elevation: 0,
                child: Icon(Icons.folder),
                labelWidget: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: const Text(
                    'Создать папку',
                    style: TextStyle(fontFamily: 'wdxl'),
                  ),
                ),
                onTap: () => _createFolderDialog(context),
              ),
            ],
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  void _createFolderDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новая папка', style: TextStyle(fontFamily: 'wdxl')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hint: const Text(
              'Введите название папки',
              style: TextStyle(fontFamily: 'wdxl'),
            ),
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Отмена', style: TextStyle(fontFamily: 'wdxl')),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<FoldersProvider>().addFolder(controller.text);
                Navigator.pop(context);
              }
            },
            child: Text('Создать', style: TextStyle(fontFamily: 'wdxl')),
          ),
        ],
      ),
    );
  }

  void _addCardToRootOrFolder(BuildContext context) {
    final cardProvider = context.read<CardProvider>();
    final cards = cardProvider.cards;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Выберите карточку", style: TextStyle(fontFamily: 'wdxl')),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              final card = cards[index];
              return ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(FluentIcons.card_ui_24_regular),
                title: Text(card.word, style: TextStyle(fontFamily: 'wdxl')),
                onTap: () {
                  Navigator.pop(context);
                  _showAddOptions(context, card);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAddOptions(BuildContext context, LearningCard card) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      useSafeArea: true,
      context: context,
      builder: (context) => SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                leading: Icon(Icons.folder),
                title: Text(
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
                title: Text(
                  'Добавить в корень',
                  style: TextStyle(fontFamily: 'wdxl'),
                ),
                onTap: () {
                  context.read<FoldersProvider>().addCardToRoot(card.id);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Карточка добавлена в корень',
                        style: TextStyle(fontFamily: "wdxl"),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFolderSelection(BuildContext context, LearningCard card) {
    final folderProvider = context.read<FoldersProvider>();
    final folders = folderProvider.folders;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: index == 0
                          ? BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )
                          : BorderRadius.zero,
                    ),
                    leading: const Icon(Icons.folder_open),
                    title: Text(
                      folder.name,
                      style: TextStyle(fontFamily: 'wdxl'),
                    ),
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
