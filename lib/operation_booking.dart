import 'package:hive/hive.dart';

part 'operation_booking.g.dart';

@HiveType(typeId: 0)
class OperationBooking {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final String phone;
  
  @HiveField(2)
  final String age;
  
  @HiveField(3)
  final String gender;
  
  @HiveField(4)
  final String selectedDate;
  
  @HiveField(5)
  final String selectedTime;
  
  @HiveField(6)
  final String operationRoomName;
  
  @HiveField(7)
  final String patientRoomName;

  OperationBooking({
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
    required this.selectedDate,
    required this.selectedTime,
    required this.operationRoomName,
    required this.patientRoomName,
  });
}