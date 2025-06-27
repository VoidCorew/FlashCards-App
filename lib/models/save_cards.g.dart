// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_cards.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveCardsAdapter extends TypeAdapter<SaveCards> {
  @override
  final int typeId = 0;

  @override
  SaveCards read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveCards(
      id: fields[0] as String,
      word: fields[1] as String,
      reading: fields[2] as String,
      translation: fields[3] as String,
      imagePath: fields[4] as String?,
      article: fields[5] as String?,
      flag: fields[6] as String?,
      articleColor: fields[7] as int?,
      cardBackgroundColor: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SaveCards obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.reading)
      ..writeByte(3)
      ..write(obj.translation)
      ..writeByte(4)
      ..write(obj.imagePath)
      ..writeByte(5)
      ..write(obj.article)
      ..writeByte(6)
      ..write(obj.flag)
      ..writeByte(7)
      ..write(obj.articleColor)
      ..writeByte(8)
      ..write(obj.cardBackgroundColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveCardsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
