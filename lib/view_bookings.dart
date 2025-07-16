// import 'package:final_project_ypu/operation_booking.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';

// class ViewBookingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('الحجوزات المسجلة')),
//       body: ValueListenableBuilder(
//         valueListenable: Hive.box<OperationBooking>('bookings').listenable(),
//         builder: (context, Box<OperationBooking> box, _) {
//           if (box.isEmpty) {
//             return Center(child: Text('لا توجد حجوزات مسجلة'));
//           }

//           return ListView.builder(
//             itemCount: box.length,
//             itemBuilder: (context, index) {
//               final booking = box.getAt(index);
//               return Card(
//                 child: ListTile(
//                   title: Text(booking!.name),
//                   subtitle: Text('${booking.date} - ${booking.time}'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () => box.deleteAt(index),
//                   ),
//                   onTap: () => _showBookingDetails(context, booking),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showBookingDetails(BuildContext context, OperationBooking booking) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('تفاصيل الحجز'),
//         content: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('الاسم: ${booking.name}'),
//             Text('الهاتف: ${booking.phone}'),
//             // باقي التفاصيل
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('إغلاق'),
//           ),
//         ],
//       ),
//     );
//   }
// }