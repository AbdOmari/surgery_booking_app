import 'package:final_project_ypu/BookingPatientRoomsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }
}

class BookingOperationRoomsScreen extends StatefulWidget {
  static String id = "BookingOperationRoomsScreen";
  final String name;
  final String phone;
  final String age;
  final String gender;
  final String selectedDate;
  final String selectedTime;

  const BookingOperationRoomsScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
    this.selectedDate = '',
    this.selectedTime = '',
  }) : super(key: key);

  @override
  _BookingOperationRoomsScreenState createState() =>
      _BookingOperationRoomsScreenState();
}

class _BookingOperationRoomsScreenState
    extends State<BookingOperationRoomsScreen> {
  final List<Map<String, dynamic>> rooms = [
    {
      "name": "Cardiac Surgery",
      "image": "assets/images/Image_operation_Rooms/general_operation.jpg",
      "isAvailable": true,
    },
    {
      "name": "Neuro surgery",
      "image":
          "assets/images/Image_operation_Rooms/Orthopedic_Operating_Rooms.jpg",
      "isAvailable": false,
    },
    {
      "name": "Cardiac Surgery",
      "image":
          "assets/images/Image_operation_Rooms/Cardiac_Operating_Rooms.jpg",
      "isAvailable": false,
    },
    {
      "name": "Teaching Surgery",
      "image":
          "assets/images/Image_operation_Rooms/Plastic_Surgery_Operating_Rooms.jpg",
      "isAvailable": true,
    },
    {
      "name": "High Risk Surgery",
      "image": "assets/images/Image_operation_Rooms/room_operation5.jpg",
      "isAvailable": false,
    },
    {
      "name": "Emergency Surgery",
      "image": "assets/images/Image_operation_Rooms/room_operation6.jpg",
      "isAvailable": true,
    },
  ];

  int? _selectedRoomIndex;
  String filter =
      'All'; // لتخزين حالة الفلترة (كل الغرف، المتاحة أو الغير متاحة)

  // فلترة الغرف بناءً على الفلتر
  void filterRooms(String filterType) {
    setState(() {
      filter = filterType;
    });
  }

  // فتح BottomSheet لاختيار الفلتر
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
                "Filter by status",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.all_inbox, color: Colors.blue),
                title: Text(" All rooms"),
                onTap: () {
                  filterRooms('All');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text("Rooms available"),
                onTap: () {
                  filterRooms('Available');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.cancel, color: Colors.red),
                title: Text("Rooms not available"),
                onTap: () {
                  filterRooms('Not Available');
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
    // فلترة الغرف بناءً على الفلتر
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
            final isAvailable = room['isAvailable'];

            return GestureDetector(
              onTap: () {
                if (isAvailable) {
                  setState(() {
                    _selectedRoomIndex = index;
                  });

                  Future.delayed(Duration(seconds: 1), () {
                    setState(() {
                      _selectedRoomIndex = null;
                    });

                    // بعد التأثير، ننتقل إلى الصفحة التالية
                    // Navigator.pushNamed(context, BookingPatientRoomsScreen.id);

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder:
                            (context, animation, secondaryAnimation) =>
                                BookingPatientRoomsScreen(
                                  name: widget.name,
                                  phone: widget.phone,
                                  age: widget.age,
                                  gender: widget.gender,
                                  selectedDate: widget.selectedDate,
                                  selectedTime: widget.selectedTime,
                                  operationRoomName:
                                      room['name'], // هنا نرسل اسم الغرفة
                                ),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.medical_services,
                                    color: Color.fromARGB(255, 109, 104, 249),
                                  ),
                                  SizedBox(width: 8.w),
                                  Flexible(
                                    child: Text(
                                      room['name'],
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isAvailable
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color:
                                        isAvailable ? Colors.green : Colors.red,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    isAvailable ? "Available" : "Not available",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color:
                                          isAvailable
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
