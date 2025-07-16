import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatientRoomsScreen(),
    );
  }
}

class PatientRoomsScreen extends StatefulWidget {
  static String id = "PatientRoomsScreen";

  @override
  _PatientRoomsScreenState createState() => _PatientRoomsScreenState();
}

class _PatientRoomsScreenState extends State<PatientRoomsScreen> {
  final List<Map<String, dynamic>> allRooms = [
    {
      "name": "Room 101",
      "image": "assets/images/images_Patient_Rooms/room_one_person.jpg",
      "bedsAvailable": 1,
      "isAvailable": true,
    },
    {
      "name": "Room 102",
      "image": "assets/images/images_Patient_Rooms/room_two_person.jpg",
      "bedsAvailable": 2,
      "isAvailable": false,
    },
    {
      "name": "Room 103",
      "image": "assets/images/images_Patient_Rooms/room_one_person_3Star.jpg",
      "bedsAvailable": 1,
      "isAvailable": true,
    },
    {
      "name": "Room 104",
      "image": "assets/images/images_Patient_Rooms/room_three_person.jpg",
      "bedsAvailable": 3,
      "isAvailable": true,
    },
    {
      "name": "Room 105",
      "image": "assets/images/images_Patient_Rooms/room_three_person_vip.jpg",
      "bedsAvailable": 4,
      "isAvailable": false,
    },
    {
      "name": "Room 106",
      "image": "assets/images/images_Patient_Rooms/room_five_person.jpg",
      "bedsAvailable": 5,
      "isAvailable": true,
    },
    {
      "name": "Room 107",
      "image": "assets/images/images_Patient_Rooms/room_only_two_person.jpg",
      "bedsAvailable": 2,
      "isAvailable": false,
    },
  ];

  List<Map<String, dynamic>> filteredRooms = [];
  int? selectedFilter; // 1 = سرير واحد، 2 = أكثر من سريرين

  @override
  void initState() {
    super.initState();
    filteredRooms = allRooms;
  }

  void filterRooms(int? bedsFilter) {
    setState(() {
      selectedFilter = bedsFilter;
      if (bedsFilter == null) {
        filteredRooms = allRooms;
      } else if (bedsFilter == 1) {
        filteredRooms =
            allRooms.where((room) => room['bedsAvailable'] == 1).toList();
      } else if (bedsFilter == 2) {
        filteredRooms =
            allRooms.where((room) => room['bedsAvailable'] >= 2).toList();
      }
    });
  }

  void showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filter by number of beds",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.single_bed, color: Colors.blue),
                title: Text("Single bed room"),
                onTap: () {
                  filterRooms(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.king_bed, color: Colors.blue),
                title: Text("Room with two or more beds"),
                onTap: () {
                  filterRooms(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.clear, color: Colors.red),
                title: Text("Cancel filtering"),
                onTap: () {
                  filterRooms(null);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Rooms", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF3F51B5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // ← هنا تحدد لون الزر
          onPressed: () {
            Navigator.pop(context); // أو أي تنقل آخر حسب ما تريد
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: const Color.fromARGB(255, 248, 225, 13),
            ),
            onPressed: showFilterOptions,
          ),
        ],
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
            final bedsAvailable = room['bedsAvailable'];

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
                        Text(
                          room['name'],
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bed, color: Colors.blueAccent),
                            SizedBox(width: 8.w),
                            Text(
                              "Beds: $bedsAvailable",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        //   SizedBox(height: 8.h),
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         isAvailable ? Icons.check_circle : Icons.cancel,
                        //         color: isAvailable ? Colors.green : Colors.red,
                        //       ),
                        //       SizedBox(width: 8.w),
                        //       Text(
                        //         isAvailable ? "Available" : "Not available",
                        //         style: TextStyle(
                        //             fontSize: 14.sp,
                        //             color: isAvailable
                        //                 ? Colors.grey[700]
                        //                 : Colors.red),
                        //       ),
                        //     ],
                        //   ),
                        // ],
                      ],
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

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: PatientRoomsScreen(),
//     );
//   }
// }

// class PatientRoomsScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> rooms = [
//     {
//       "name": "Room 101",
//       "image": "assets/images/room_one_person.jpg",
//       "bedsAvailable": 1,
//       "isAvailable": true, // متاحة
//     },
//     {
//       "name": "Room 102",
//       "image": "assets/images/room_two_person.jpg",
//       "bedsAvailable": 2,
//       "isAvailable": false, // غير متاحة
//     },
//     {
//       "name": "Room 103",
//       "image": "assets/images/room_one_person_3Star.jpg",
//       "bedsAvailable": 1,
//       "isAvailable": true, // متاحة
//     },
//     {
//       "name": "Room 104",
//       "image": "assets/images/room_three_person.jpg",
//       "bedsAvailable": 3,
//       "isAvailable": true, // متاحة
//     },
//     {
//       "name": "Room 105",
//       "image": "assets/images/room_three_person_vip.jpg",
//       "bedsAvailable": 4,
//       "isAvailable": false, // غير متاحة
//     },
//     {
//       "name": "Room 106",
//       "image": "assets/images/room_five_person.jpg",
//       "bedsAvailable": 5,
//       "isAvailable": true, // متاحة
//     },
//     {
//       "name": "Room 106",
//       "image": "assets/images/room_only_two_person.jpg",
//       "bedsAvailable": 2,
//       "isAvailable": false, // متاحة
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Patient Rooms"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 0.8,
//           ),
//           itemCount: rooms.length,
//           itemBuilder: (context, index) {
//             final room = rooms[index];
//             final isAvailable = room['isAvailable'];
//             final bedsAvailable = room['bedsAvailable'];

//             return Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(15)),
//                       child: Image.asset(
//                         room['image'],
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         // اسم الغرفة
//                         Text(
//                           room['name'],
//                           style: TextStyle(
//                               fontSize: 18.sp, fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: 8.h), // مسافة بين العناصر
//                         // عدد الأسرة المتاحة
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.bed,
//                                 color: Colors.blueAccent), // أيقونة السرير
//                             SizedBox(width: 8.w), // مسافة بين الأيقونة والنص
//                             Text(
//                               "Beds: $bedsAvailable",
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 8.h), // مسافة بين العناصر
//                         // حالة الغرفة
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               isAvailable
//                                   ? Icons.check_circle
//                                   : Icons.cancel, // أيقونة بناءً على الحالة
//                               color: isAvailable
//                                   ? Colors.green
//                                   : Colors.red, // لون الأيقونة
//                             ),
//                             SizedBox(width: 8.w), // مسافة بين الأيقونة والنص
//                             Text(
//                               isAvailable
//                                   ? "Available"
//                                   : "Not available", // النص بناءً على الحالة
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 color:
//                                     isAvailable ? Colors.grey[700] : Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
