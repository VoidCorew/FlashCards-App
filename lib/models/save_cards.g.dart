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
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as int?,
      fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SaveCards obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.word)
      ..writeByte(1)
      ..write(obj.reading)
      ..writeByte(2)
      ..write(obj.translation)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.article)
      ..writeByte(5)
      ..write(obj.flag)
      ..writeByte(6)
      ..write(obj.articleColor)
      ..writeByte(7)
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
