import 'package:card_learn_languages/models/folder.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FoldersProvider extends ChangeNotifier {
  late Box<Folder> _folderBox;
  List<Folder> _folders = [];

  FoldersProvider() {}

  Future<void> _init() async {
    _folderBox = await Hive.openBox<Folder>('folders');
    _loadFolders();
  }

  void _loadFolders() {
    _folders = _folderBox.values.toList();
    notifyListeners();
  }

  List<Folder> get folders => _folders;

  void addFolder(String name) {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final newFolder = Folder(id: id, name: name);
    _folderBox.add(newFolder);
    folders.add(newFolder);
    notifyListeners();
  }

  void addCardToFolder() {}
}
