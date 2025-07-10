import 'package:card_learn_languages/models/folder.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/providers/folders_provider.dart';
import 'package:card_learn_languages/widgets/custom_old_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FolderCardsScreen extends StatelessWidget {
  final String folderId;
  const FolderCardsScreen({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    // debugPrint('Загрузка экрана папки: $folderId');

    final folderProvider = context.watch<FoldersProvider>();
    final folder = context.watch<FoldersProvider>().folders.firstWhere(
      (f) => f.id == folderId,
      orElse: () {
        return Folder(id: 'error', name: 'Ошибка');
      },
    );

    // debugPrint('Карточки в папке ${folder.name}: ${folder.cardsIds}');

    final cardProvider = context.watch<CardProvider>();
    final cards = cardProvider.cards
        .where((card) => folder.cardsIds.contains(card.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(folder.name),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Удаление папки с подтверждением
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Удалить папку?"),
                  content: Text("Все карточки останутся в приложении"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop,
                      child: Text("Отмена"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<FoldersProvider>().deleteFolder(folderId);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Удалить",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return CustomOldCard(
            card: card,
            index: cardProvider.cards.indexWhere((c) => c.id == card.id),
            onAddPressed: () {}, // Отключаем функционал в этом экране
          );
        },
      ),
    );
  }
}
