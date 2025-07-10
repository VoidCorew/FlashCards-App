// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_learning_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LearningCardAdapterAdapter extends TypeAdapter<LearningCardAdapter> {
  @override
  final int typeId = 2;

  @override
  LearningCardAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LearningCardAdapter(
      id: fields[0] as String,
      imagePath: fields[1] as String?,
      article: fields[2] as String?,
      flag: fields[3] as String?,
      word: fields[5] as String,
      reading: fields[6] as String,
      translation: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LearningCardAdapter obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.article)
      ..writeByte(3)
      ..write(obj.flag)
      ..writeByte(4)
      ..write(obj.articleColorValue)
      ..writeByte(5)
      ..write(obj.word)
      ..writeByte(6)
      ..write(obj.reading)
      ..writeByte(7)
      ..write(obj.translation)
      ..writeByte(8)
      ..write(obj.cardBackgroundColorValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LearningCardAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
