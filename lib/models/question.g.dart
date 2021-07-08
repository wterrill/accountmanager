// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 2;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      benefitsBusinessValue: fields[0] as String?,
      category: fields[1] as String?,
      customerApprovedProject: fields[2] as String?,
      estimatedLaborPrice: fields[3] as String?,
      estimatedMRRIncrease: fields[4] as String?,
      estimatedProductPrice: fields[5] as String?,
      howTo: fields[6] as String?,
      projectType: fields[7] as String?,
      questionName: fields[8] as String?,
      questionPriority: fields[9] as String?,
      questionText: fields[10] as String?,
      roadMap: fields[11] as String?,
      section: fields[12] as String?,
      sysAdminNotes: fields[13] as String?,
      sysAdminReviewAligned: fields[14] as bool?,
      goodBadAnswer: fields[15] as String?,
      tamRecommendations: fields[16] as String?,
      tamReview: fields[17] as String?,
      totalProjectEstimate: fields[18] as String?,
      type: fields[19] as String?,
      whyAreWeAsking: fields[20] as String?,
      id: fields[21] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.benefitsBusinessValue)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.customerApprovedProject)
      ..writeByte(3)
      ..write(obj.estimatedLaborPrice)
      ..writeByte(4)
      ..write(obj.estimatedMRRIncrease)
      ..writeByte(5)
      ..write(obj.estimatedProductPrice)
      ..writeByte(6)
      ..write(obj.howTo)
      ..writeByte(7)
      ..write(obj.projectType)
      ..writeByte(8)
      ..write(obj.questionName)
      ..writeByte(9)
      ..write(obj.questionPriority)
      ..writeByte(10)
      ..write(obj.questionText)
      ..writeByte(11)
      ..write(obj.roadMap)
      ..writeByte(12)
      ..write(obj.section)
      ..writeByte(13)
      ..write(obj.sysAdminNotes)
      ..writeByte(14)
      ..write(obj.sysAdminReviewAligned)
      ..writeByte(15)
      ..write(obj.goodBadAnswer)
      ..writeByte(16)
      ..write(obj.tamRecommendations)
      ..writeByte(17)
      ..write(obj.tamReview)
      ..writeByte(18)
      ..write(obj.totalProjectEstimate)
      ..writeByte(19)
      ..write(obj.type)
      ..writeByte(20)
      ..write(obj.whyAreWeAsking)
      ..writeByte(21)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
