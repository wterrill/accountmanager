// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tbr_in_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TBRinProgressAdapter extends TypeAdapter<TBRinProgress> {
  @override
  final int typeId = 1;

  @override
  TBRinProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TBRinProgress()
      ..allQuestions = (fields[0] as List?)?.cast<Question>()
      ..sections = (fields[1] as List).cast<String?>()
      ..categories = (fields[2] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String?>()))
      ..percentages = (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as Map).cast<String, double>()))
      ..totalPercent = fields[4] as double
      ..answers = (fields[5] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String?, (v as List?)?.cast<bool>()))
      ..colorScheme = (fields[6] as Map).map((dynamic k, dynamic v) => MapEntry(
          k as String?,
          (v as Map).map((dynamic k, dynamic v) =>
              MapEntry(k as String, (v as List).cast<int?>()))))
      ..adminComment = (fields[7] as Map?)?.cast<String?, String>()
      ..tamNotes = (fields[8] as Map?)?.cast<String?, String>()
      ..showSubmitButton = fields[9] as bool
      ..id = fields[10] as String?;
  }

  @override
  void write(BinaryWriter writer, TBRinProgress obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.allQuestions)
      ..writeByte(1)
      ..write(obj.sections)
      ..writeByte(2)
      ..write(obj.categories)
      ..writeByte(3)
      ..write(obj.percentages)
      ..writeByte(4)
      ..write(obj.totalPercent)
      ..writeByte(5)
      ..write(obj.answers)
      ..writeByte(6)
      ..write(obj.colorScheme)
      ..writeByte(7)
      ..write(obj.adminComment)
      ..writeByte(8)
      ..write(obj.tamNotes)
      ..writeByte(9)
      ..write(obj.showSubmitButton)
      ..writeByte(10)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TBRinProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
