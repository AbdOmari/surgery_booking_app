// import 'package:final_project_ypu/finaleditbooking.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'HomePage.dart'; // تأكد من استيراد الصفحة الرئيسية
// import 'appointment_model.dart';
// import 'Booking_scree.dart';

// class DoctorAppointmentManagementScreen extends StatefulWidget {
//   static const String id = "DoctorAppointmentManagementScreen";

//   const DoctorAppointmentManagementScreen({Key? key}) : super(key: key);

//   @override
//   State<DoctorAppointmentManagementScreen> createState() =>
//       _DoctorAppointmentManagementScreenState();
// }

// class _DoctorAppointmentManagementScreenState
//     extends State<DoctorAppointmentManagementScreen> {
//   List<Appointment> _appointments = [
//     Appointment(
//       patientName: "Abdulrhman Alomari",
//       dateTime: DateTime(2024, 2, 5, 8, 00),
//       operatingRoom: "Emergency",
//       patientRoom: "Room 106", // إضافة غرفة المرضى
//     ),
//     Appointment(
//       patientName: "Ahmad Alaous",
//       dateTime: DateTime(2024, 1, 30, 3, 00),
//       operatingRoom: "Teching ",
//       patientRoom: "Room 104", // إضافة غرفة المرضى
//     ),
//     Appointment(
//       patientName: "Raghad Almaleh",
//       dateTime: DateTime(2024, 2, 5, 8, 00),
//       operatingRoom: "Cardiac",
//       patientRoom: "Room 102", // إضافة غرفة المرضى
//     ),
//   ];

//   // دالة لتأكيد الحذف
//   Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
//     return showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Confirm delete"),
//           content:
//               Text("Are you sure you want to delete this appointment?"),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // دالة لإدارة زر الرجوع
//   Future<bool> _onWillPop() async {
//     // عند الضغط على زر الرجوع، سيتم التوجيه إلى الصفحة الرئيسية
//     Navigator.pushNamedAndRemoveUntil(
//       context,
//       HomePage.id, // العودة إلى الصفحة الرئيسية
//       (route) => false, // إزالة جميع الصفحات السابقة
//     );
//     return false; // منع العودة إلى الصفحة السابقة
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop, // استدعاء الدالة عند الضغط على زر الرجوع
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Appointment Management',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Color.fromARGB(255, 109, 104, 249),
//         ),
//         body: _appointments.isEmpty
//             ? const Center(child: Text("There are no appointments yet"))
//             : ListView.builder(
//                 itemCount: _appointments.length,
//                 itemBuilder: (context, index) {
//                   final appointment = _appointments[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 16.0),
//                     child: Card(
//                       elevation: 5,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 12),
//                         title: Text(
//                           appointment.patientName,
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 109, 104, 249),
//                               fontSize: 18.sp),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 6.h),
//                             Row(
//                               children: [
//                                 Icon(Icons.calendar_today,
//                                     size: 16,
//                                     color: Color.fromARGB(255, 25, 123, 194)),
//                                 SizedBox(width: 4.w),
//                                 Text(
//                                   DateFormat('dd/MM/yyyy hh:mm a')
//                                       .format(appointment.dateTime),
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 6.h),
//                             Row(
//                               children: [
//                                 Icon(Icons.room_service,
//                                     size: 16,
//                                     color: Color.fromARGB(255, 25, 123, 194)),
//                                 SizedBox(width: 4.w),
//                                 Text(
//                                   "Operating Room: ${appointment.operatingRoom}",
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 6.h),
//                             Row(
//                               children: [
//                                 Icon(Icons.local_hospital,
//                                     size: 16,
//                                     color: Color.fromARGB(255, 25, 123, 194)),
//                                 SizedBox(width: 4.w),
//                                 Text(
//                                   "Patient Room: ${appointment.patientRoom}",
//                                   style: TextStyle(color: Colors.grey[600]),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: const Icon(Icons.edit, color: Colors.blue),
//                               onPressed: () async {
//                                 final originalPatientName =
//                                     appointment.patientName;
//                                 final result = await Navigator.pushNamed(
//                                   context,
//                                   AppointmentBookingScreen.id,
//                                   arguments: {'appointment': appointment},
//                                 );
//                                 if (result != null && result is Appointment) {
//                                   setState(() {
//                                     _appointments[index] = Appointment(
//                                       patientName: originalPatientName,
//                                       dateTime: result.dateTime,
//                                       operatingRoom: result.operatingRoom,
//                                       patientRoom: result.patientRoom,
//                                     );
//                                   });
//                                 }
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () async {
//                                 final confirmDelete =
//                                     await _showDeleteConfirmationDialog(
//                                         context);
//                                 if (confirmDelete != null && confirmDelete) {
//                                   setState(() {
//                                     _appointments.removeAt(index);
//                                   });
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
