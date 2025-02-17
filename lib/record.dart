import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Record extends HiveObject {
  @HiveField(0)
  String type;

  @HiveField(1)
  int score;

  Record({required this.type, required this.score});
}

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId = 0;

  @override
  Record read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Record(
      type: fields[0] as String,
      score: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RecordAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
