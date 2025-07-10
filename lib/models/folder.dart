import 'package:hive/hive.dart';

part 'folder.g.dart';

@HiveType(typeId: 1)
class Folder extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> cardsIds;

  Folder({required this.id, required this.name, List<String>? cardsIds})
    : cardsIds = cardsIds ?? [];

  void addCard(String cardId) {
    cardsIds.add(cardId);
    save();
  }
}
