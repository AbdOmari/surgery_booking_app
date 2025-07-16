// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationBookingAdapter extends TypeAdapter<OperationBooking> {
  @override
  final int typeId = 0;

  @override
  OperationBooking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OperationBooking(
      name: fields[0] as String,
      phone: fields[1] as String,
      age: fields[2] as String,
      gender: fields[3] as String,
      selectedDate: fields[4] as String,
      selectedTime: fields[5] as String,
      operationRoomName: fields[6] as String,
      patientRoomName: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OperationBooking obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.selectedDate)
      ..writeByte(5)
      ..write(obj.selectedTime)
      ..writeByte(6)
      ..write(obj.operationRoomName)
      ..writeByte(7)
      ..write(obj.patientRoomName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationBookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
