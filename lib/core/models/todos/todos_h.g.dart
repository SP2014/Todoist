// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodosHAdapter extends TypeAdapter<TodosH> {
  @override
  final typeId = 0;

  @override
  TodosH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodosH(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      isCompleted: fields[3] as bool,
      category: fields[4] as String,
      priority: fields[5] as String,
      timestamp: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TodosH obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.priority)
      ..writeByte(6)
      ..write(obj.timestamp);
  }
}
