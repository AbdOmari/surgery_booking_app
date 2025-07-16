// class Appointment {
//   DateTime dateTime;
//   String operatingRoom;
//   String patientName;

//   Appointment({
//     required this.dateTime,
//     required this.operatingRoom,
//     required this.patientName,
//   });

//   Map<String, dynamic> toJson() => {
//         'dateTime': dateTime.toIso8601String(),
//         'operatingRoom': operatingRoom,
//         'patientName': patientName,
//       };

//   factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
//         dateTime: DateTime.parse(json['dateTime']),
//         operatingRoom: json['operatingRoom'],
//         patientName: json['patientName'],
//       );
// }

// class ExtendedAppointment extends Appointment {
//   String name;
//   String phone;
//   String age;
//   String gender;
//   DateTime? selectedDay;
//   String? selectedTime;
//   String? operationRoom;
//   String? patientRoom;

//   ExtendedAppointment({
//     required DateTime dateTime,
//     required String operatingRoom,
//     required String patientName,
//     required this.name,
//     required this.phone,
//     required this.age,
//     required this.gender,
//     this.selectedDay,
//     this.selectedTime,
//     this.operationRoom,
//     this.patientRoom,
//   }) : super(
//           dateTime: dateTime,
//           operatingRoom: operatingRoom,
//           patientName: patientName,
//         );

//   @override
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = super.toJson();
//     data.addAll({
//       'name': name,
//       'phone': phone,
//       'age': age,
//       'gender': gender,
//       'selectedDay': selectedDay?.toIso8601String(),
//       'selectedTime': selectedTime,
//       'operationRoom': operationRoom,
//       'patientRoom': patientRoom,
//     });
//     return data;
//   }

//   factory ExtendedAppointment.fromJson(Map<String, dynamic> json) {
//     return ExtendedAppointment(
//       dateTime: DateTime.parse(json['dateTime']),
//       operatingRoom: json['operatingRoom'],
//       patientName: json['patientName'],
//       name: json['name'],
//       phone: json['phone'],
//       age: json['age'],
//       gender: json['gender'],
//       selectedDay: json['selectedDay'] != null ? DateTime.parse(json['selectedDay']) : null,
//       selectedTime: json['selectedTime'],
//       operationRoom: json['operationRoom'],
//       patientRoom: json['patientRoom'],
//     );
//   }
// }

// class Appointment {
//   String name;
//   String phone;
//   String age;
//   String gender;
//   DateTime? selectedDay;
//   String? selectedTime;
//   String? operationRoom;
//   String? patientRoom;

//   Appointment({
//     required this.name,
//     required this.phone,
//     required this.age,
//     required this.gender,
//     this.selectedDay,
//     this.selectedTime,
//     this.operationRoom,
//     this.patientRoom,
//   });
// }

// class Appointment {
//   DateTime dateTime;
//   String operatingRoom;
//   String patientName;

//   Appointment({
//     required this.dateTime,
//     required this.operatingRoom,
//     required this.patientName,
//   });

//   Map<String, dynamic> toJson() => {
//         'dateTime': dateTime.toIso8601String(),
//         'operatingRoom': operatingRoom,
//         'patientName': patientName,
//       };

//   factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
//         dateTime: DateTime.parse(json['dateTime']),
//         operatingRoom: json['operatingRoom'],
//         patientName: json['patientName'],
//       );
// }


class Appointment {
  DateTime dateTime;
  String operatingRoom;
  String patientName;
  String patientRoom; // إضافة حقل غرفة المرضى

  Appointment({
    required this.dateTime,
    required this.operatingRoom,
    required this.patientName,
    required this.patientRoom, // إضافة رقم غرفة المرضى في المُنشئ
  });

  // تحويل الكائن إلى JSON مع إضافة patientRoom
  Map<String, dynamic> toJson() => {
        'dateTime': dateTime.toIso8601String(),
        'operatingRoom': operatingRoom,
        'patientName': patientName,
        'patientRoom': patientRoom, // إضافة patientRoom
      };

  // تحويل JSON إلى كائن Appointment مع إضافة patientRoom
  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        dateTime: DateTime.parse(json['dateTime']),
        operatingRoom: json['operatingRoom'],
        patientName: json['patientName'],
        patientRoom: json['patientRoom'], // إضافة patientRoom
      );
}
