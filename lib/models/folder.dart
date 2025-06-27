import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Folder {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final List<String> cardsIds;

  Folder({required this.id, required this.name, List<String>? cardIds})
    : cardsIds = cardIds ?? [];
}
