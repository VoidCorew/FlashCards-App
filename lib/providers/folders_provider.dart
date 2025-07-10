import 'package:card_learn_languages/models/folder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FoldersProvider extends ChangeNotifier {
  late Box<Folder> _folderBox;
  late Box<String> _rootCardsBox;
  List<Folder> _folders = [];
  List<String> _rootCards = [];

  FoldersProvider() {
    _init();
  }

  List<Folder> get folders => _folders;
  List<String> get rootCards => _rootCards;

  // ааа, тут не надо открывать боксы, их надо только в main открывать
  Future<void> _init() async {
    // _folderBox = await Hive.openBox<Folder>('folders');
    // _rootCardsBox = await Hive.openBox<String>('root_cards');
    _folderBox = Hive.box<Folder>('folders');
    _rootCardsBox = Hive.box<String>('root_cards');
    loadAllData();
  }

  void loadAllData() {
    _folders = _folderBox.values.toList();
    _rootCards = _rootCardsBox.values.toList();
    notifyListeners();
  }

  // Future<void> loadAllData() async {
  //   _folders = _folderBox.values.toList();
  //   _rootCards = _rootCardsBox.values.toList();
  //   notifyListeners();
  // }

  // добавляем в корень экрана по id карточки
  void addCardToRoot(String cardId) {
    if (!_rootCards.contains(cardId)) {
      // _rootCards.add(cardId);
      _rootCardsBox.add(cardId);
      loadAllData();
      // notifyListeners();
    }
  }

  // удаляем с корня экрана по id, а из Hive по ключу, который является нашим индексом
  void removeCardFromRoot(String cardId) {
    final idx = _rootCardsBox.values.toList().indexOf(cardId);
    if (idx != -1) {
      final key = _rootCardsBox.keyAt(idx);
      _rootCardsBox.delete(key);
      loadAllData();
    }
    // if (_rootCards.contains(cardId)) {
    //   _rootCards.remove(cardId);
    //   final key = box.keyAt(box.values.toList().indexOf(cardId));
    //   box.delete(key);
    //   notifyListeners();
    // }
  }

  // добавить папку в корень, мы используем id как время создания папки,
  //! но я не понимаю что это значит microsecondsSinceEpoch
  void addFolder(String name) {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    // final newFolder = Folder(id: id, name: name);
    _folderBox.add(Folder(id: id, name: name));
    // folders.add(newFolder);
    loadAllData();
  }

  // добавляем карточку в папку
  // я не понимаю этот метод
  //! _folders.firstWhere((f) => f.id == folderId);
  void addCardToFolder(String cardId, String folderId) {
    final folder = _folders.firstWhere((f) => f.id == folderId);
    if (!folder.cardsIds.contains(cardId)) {
      // аааа, я понял, у меня же ведь в Folder метод addCard
      // и так сохраняет
      // folder.addCard(cardId);
      folder.cardsIds.add(cardId);
      folder.save();
      loadAllData();
      // просто я тут заметил что карточка добавляется в папку, но она в этой папке не сохраняется
      // но я не думаю что я правильно сделал
    }
  }

  // удалить карточку с папки
  void removeCardFromFolder(String cardId, String folderId) {
    final folder = _folderBox.values.firstWhere(
      (f) => f.id == folderId,
    ); // аналогично и это я не понимаю
    // и я подумал что тут наверное нужна проверка на то, что эта карточка есть
    // я честно не понимаю как это делать
    // if (folder.cardsIds.contains(cardId)) {
    //   folder.cardsIds.remove(cardId);
    //   folder.save();
    //   notifyListeners();
    // }
    if (folder.cardsIds.remove(cardId)) {
      folder.save();
      loadAllData();
    }
  }

  // удалить папку
  // а почему тут просто .delete(), а с карточкой
  // folder.cardsIds.add(cardId);
  // folder.save();
  // ?
  void deleteFolder(String folderId) {
    final folder = _folders.firstWhere((f) => f.id == folderId);
    folder.delete();
    // я и это еще не понимаю
    // _folders.removeWhere((f) => f.id == folderId);
    loadAllData();
  }
}
