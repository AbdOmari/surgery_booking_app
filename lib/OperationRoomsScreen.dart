import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OperationRoomsScreen(),
    );
  }
}

class OperationRoomsScreen extends StatefulWidget {
  static String id = "OperationRoomsScreen";

  @override
  _OperationRoomsScreenState createState() => _OperationRoomsScreenState();
}

class _OperationRoomsScreenState extends State<OperationRoomsScreen> {
  final List<Map<String, dynamic>> rooms = [
    {
      "name": "Cardiac Surgery",
      "image": "assets/images/Image_operation_Rooms/general_operation.jpg",
      "isAvailable": true, // متاحة
    },
    {
      "name": "Neuro surgery",
      "image":
          "assets/images/Image_operation_Rooms/Orthopedic_Operating_Rooms.jpg",
      "isAvailable": false, // غير متاحة
    },
    {
      "name": "Cardiac Surgery",
      "image":
          "assets/images/Image_operation_Rooms/Cardiac_Operating_Rooms.jpg",
      "isAvailable": false, // غير متاحة
    },
    {
      "name": "Teaching Surgery",
      "image":
          "assets/images/Image_operation_Rooms/Plastic_Surgery_Operating_Rooms.jpg",
      "isAvailable": true, // متاحة
    },
    {
      "name": "High Risk Surgery",
      "image": "assets/images/Image_operation_Rooms/room_operation5.jpg",
      "isAvailable": false, // غير متاحة
    },
    {
      "name": "Emergency Surgery",
      "image": "assets/images/Image_operation_Rooms/room_operation6.jpg",
      "isAvailable": true, // متاحة
    },
  ];

  String filter =
      'All'; // لتخزين حالة الفلترة (كل الغرف، المتاحة أو الغير متاحة)

  @override
  Widget build(BuildContext context) {
    // فلترة الغرف بناءً على الحالة
    List<Map<String, dynamic>> filteredRooms = rooms;
    if (filter == 'Available') {
      filteredRooms =
          rooms.where((room) => room['isAvailable'] == true).toList();
    } else if (filter == 'Not Available') {
      filteredRooms =
          rooms.where((room) => room['isAvailable'] == false).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Operation Rooms", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3F51B5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // ← هنا تحدد لون الزر
          onPressed: () {
            Navigator.pop(context); // أو أي تنقل آخر حسب ما تريد
          },
        ),
        // actions: [
        //   PopupMenuButton<String>(
        //     onSelected: (value) {
        //       setState(() {
        //         filter = value; // تحديث الفلتر بناءً على اختيار المستخدم
        //       });
        //     },
        //     itemBuilder: (context) => [
        //       PopupMenuItem<String>(
        //         value: 'All',
        //         child: Text('All Rooms'),
        //       ),
        //       PopupMenuItem<String>(
        //         value: 'Available',
        //         child: Text('Available Rooms'),
        //       ),
        //       PopupMenuItem<String>(
        //         value: 'Not Available',
        //         child: Text('Not Available Rooms'),
        //       ),
        //     ],
        //     // icon: Icon(Icons.filter_list), // أيقونة الفلتر
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: filteredRooms.length,
          itemBuilder: (context, index) {
            final room = filteredRooms[index];
            final isAvailable = room['isAvailable'];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: Image.asset(
                        room['image'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // اسم العملية مع أيقونة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.medical_services,
                              color: Colors.blueAccent,
                            ), // أيقونة
                            SizedBox(width: 8.w), // مسافة بين الأيقونة والنص
                            Flexible(
                              child: Text(
                                room['name'],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow:
                                    TextOverflow
                                        .ellipsis, // تقصير النص إذا كان طويلاً
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h), // مسافة بين العناصر
                        // نص "متاحة" أو "غير متاحة" مع أيقونة
                        //   Row (
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         isAvailable
                        //             ? Icons.check_circle
                        //             : Icons.cancel, // أيقونة بناءً على الحالة
                        //         color: isAvailable
                        //             ? Colors.green
                        //             : Colors.red, // لون الأيقونة
                        //       ),
                        //       SizedBox(width: 8.w), // مسافة بين الأيقونة والنص
                        //       Text(
                        //         isAvailable
                        //             ? "Available"
                        //             : "Not available", // النص بناءً على الحالة
                        //         style: TextStyle(
                        //           fontSize: 14.sp,
                        //           color:
                        //               isAvailable ? Colors.grey[700] : Colors.red,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                      ], // ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
