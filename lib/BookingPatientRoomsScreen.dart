import 'package:final_project_ypu/DoctorAppointmentManagementScreen2.dart';
import 'package:final_project_ypu/editbooking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
    );
  }
}

class BookingPatientRoomsScreen extends StatefulWidget {
  static String id = "BookingPatientRoomsScreen";

  final String name;
  final String phone;
  final String age;
  final String gender;
  final String selectedDate;
  final String selectedTime;
  final String operationRoomName;

  const BookingPatientRoomsScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
    required this.selectedDate,
    required this.selectedTime,
    required this.operationRoomName,
  }) : super(key: key);

  @override
  _BookingPatientRoomsScreenState createState() =>
      _BookingPatientRoomsScreenState();
}

class _BookingPatientRoomsScreenState extends State<BookingPatientRoomsScreen> {
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

  int? _selectedRoomIndex;
  int? filterBeds; // عدد الأسرة المستخدم في الفلتر

  void filterRooms(int? beds) {
    setState(() {
      filterBeds = beds;
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
    List<Map<String, dynamic>> filteredRooms = allRooms;

    if (filterBeds != null) {
      if (filterBeds == 1) {
        filteredRooms =
            allRooms.where((room) => room['bedsAvailable'] == 1).toList();
      } else {
        filteredRooms =
            allRooms.where((room) => room['bedsAvailable'] >= 2).toList();
      }
    }

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
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: showFilterOptions, // فتح الفلتر عند الضغط
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

            return GestureDetector(
              onTap: () {
                if (room['isAvailable']) {
                  setState(() {
                    _selectedRoomIndex = index;
                  });

                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      _selectedRoomIndex = null;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DoctorAppointmentManagementScreen2(
                              name: widget.name,
                              phone: widget.phone,
                              age: widget.age,
                              gender: widget.gender,
                              selectedDate: widget.selectedDate,
                              selectedTime: widget.selectedTime,
                              operationRoomName: widget.operationRoomName,
                              patientRoomName:
                                  room['name'], // هذا اسم غرفة المريض الجديدة
                            ),
                      ),
                    );
                  });
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Card(
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
                                    "Beds: ${room['bedsAvailable']}",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    room['isAvailable']
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color:
                                        room['isAvailable']
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    room['isAvailable']
                                        ? "Available"
                                        : "Not available",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color:
                                          room['isAvailable']
                                              ? Colors.grey[700]
                                              : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_selectedRoomIndex == index)
                    Positioned(
                      child: Lottie.asset(
                        'assets/animations/threeCircle.json',
                        height: 100.h,
                        fit: BoxFit.cover,
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
