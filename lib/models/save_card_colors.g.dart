// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_card_colors.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveCardColorsAdapter extends TypeAdapter<SaveCardColors> {
  @override
  final int typeId = 4;

  @override
  SaveCardColors read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveCardColors(
      recentArticleColors: (fields[1] as List).cast<int>(),
      recentCardBackgroundColors: (fields[0] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, SaveCardColors obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.recentCardBackgroundColors)
      ..writeByte(1)
      ..write(obj.recentArticleColors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveCardColorsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
