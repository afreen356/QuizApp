// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      firebaseId: fields[0] as String?,
      username: fields[1] as String,
      gmail: fields[2] as String,
      age: fields[3] as String,
      question: fields[4] as String,
      correctAnswerIndex: (fields[5] as List).toSet().cast<String>(),
      score: fields[7] as int,
      id: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.firebaseId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.gmail)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.question)
      ..writeByte(5)
      ..write(obj.correctAnswerIndex.toList())
      ..writeByte(7)
      ..write(obj.score)
      ..writeByte(8)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
