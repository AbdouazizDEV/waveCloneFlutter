// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      nom: fields[1] as String,
      prenom: fields[2] as String,
      telephone: fields[3] as String,
      email: fields[4] as String,
      solde: fields[5] as double,
      code: fields[6] as String,
      promo: fields[7] as double,
      carte: fields[8] as String,
      etatcarte: fields[9] as bool,
      roleId: fields[10] as int,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.prenom)
      ..writeByte(3)
      ..write(obj.telephone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.solde)
      ..writeByte(6)
      ..write(obj.code)
      ..writeByte(7)
      ..write(obj.promo)
      ..writeByte(8)
      ..write(obj.carte)
      ..writeByte(9)
      ..write(obj.etatcarte)
      ..writeByte(10)
      ..write(obj.roleId)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
