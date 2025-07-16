import 'package:final_project_ypu/AboutScreen%20.dart';
import 'package:final_project_ypu/AppointmentSummaryScreen%20.dart';
import 'package:final_project_ypu/ConfirmedBookingsScreen.dart';
import 'package:final_project_ypu/LogIn.dart';
import 'package:final_project_ypu/OperationRoomsScreen.dart';
import 'package:final_project_ypu/PatientRoomsScreen.dart';
import 'package:final_project_ypu/Patient_information.dart';
import 'package:final_project_ypu/all_bookings_screen.dart';
import 'package:final_project_ypu/editbooking.dart';
import 'package:final_project_ypu/profile_doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> news = [
    {
      'type': 'alert',
      'title': 'Change in Dr. Ahmed\'s Operation Schedule',
      'content':
          'Dr. Ahmed\'s operation has been rescheduled for tomorrow at 10:00 AM.',
      'date': '2024-10-27 10:00:00',
    },
    {
      'type': 'news',
      'title': 'Operating Room Management System Updated',
      'content': 'The system has been successfully updated with new features.',
      'date': '2024-10-26 14:30:00',
    },
    {
      'type': 'announcement',
      'title': 'New Anesthesia Machine Available in OR 3',
      'content':
          'Operating Room 3 is now equipped with a modern anesthesia machine.',
      'date': '2024-10-25 09:00:00',
    },
    {
      'type': 'alert',
      'title': 'Emergency Meeting for Department Heads',
      'content':
          'All department heads must attend an emergency meeting tomorrow at 12:00 PM.',
      'date': '2024-10-24 16:00:00',
    },
    {
      'type': 'news',
      'title': 'Workshop on Modern Surgical Techniques',
      'content':
          'A workshop on modern surgical techniques will be held next week.',
      'date': '2024-10-23 11:00:00',
    },
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); // Initialize date formatting
  }

  IconData getIcon(String type) {
    switch (type) {
      case 'alert':
        return Icons.notifications_active;
      case 'news':
        return Icons.article;
      case 'announcement':
        return Icons.campaign;
      default:
        return Icons.info;
    }
  }

  Color getColor(String type) {
    switch (type) {
      case 'alert':
        return const Color(0xFFE57373);
      case 'news':
        return const Color(0xFF64B5F6);
      case 'announcement':
        return const Color(0xFF81C784);
      default:
        return const Color(0xFFA1887F);
    }
  }

  Color getBackgroundColor(String type) {
    switch (type) {
      case 'alert':
        return const Color(0xFFFFEBEE);
      case 'news':
        return const Color(0xFFE3F2FD);
      case 'announcement':
        return const Color(0xFFE8F5E9);
      default:
        return const Color(0xFFEFEBE9);
    }
  }

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('MMM d, y h:mm a').format(dateTime);
    } catch (e) {
      debugPrint('Error parsing date: $e');
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('userBox');
    final username = box.get('username', defaultValue: 'Guest');
    final password = box.get('password', defaultValue: '');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F51B5),
        title: Text(
          'Hospital OR Booking System',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF303F9F), // أزرق داكن (أعمق من اللون الأساسي)
                Color(0xFF3F51B5), // اللون الأساسي
                Color(0xFF7986CB), // أزرق فاتح (تدرج لطيف)تدرج أفتح
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.5, 1.0], // توزيع التدرج
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF283593), // أزرق داكن جداً
                      Color(0xFF3949AB), // أزرق داكن
                      Color(0xFF5C6BC0), // // اللون الأساسي
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),

                accountName: Text(
                  'Dr. $username',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
                accountEmail: Text(
                  '${username}@gmail.com',
                  style: TextStyle(color: Colors.white),
                ),

                currentAccountPicture: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://www.w3schools.com/howto/img_avatar.png',
                  ),
                  onBackgroundImageError: (exception, stackTrace) {
                    // معالجة الخطأ عند عدم تحميل الصورة
                    print('Error loading image: $exception');
                    // يمكنك هنا عرض صورة افتراضية
                  },
                ),
              ),
              _buildDrawerItem(
                icon: Icons.person,
                title: 'Profile',
                onTap:
                    () => Navigator.pushNamed(
                      context,
                      DoctorProfileScreen.id,
                      arguments: {'username': username, 'password': password},
                    ),
              ),
              _buildDrawerItem(
                icon: Icons.calendar_today,
                title: 'Book Operating Room',
                onTap:
                    () => Navigator.pushNamed(context, Patient_information.id),
              ),
              _buildDrawerItem(
                icon: Icons.assignment,
                title: 'All Booking',
                onTap:
                    () => Navigator.pushNamed(
                      context,
                      AllBookingsScreen.id,
                      // DoctorAppointmentManagementScreen
                    ),
              ),
              _buildDrawerItem(
                icon: Icons.check_circle,
                title: 'Confirmed Booking',
                onTap:
                    () => Navigator.pushNamed(
                      context,
                      ConfirmedBookingsScreen.id,
                    ),
              ),
              _buildDrawerItem(
                icon: Icons.medical_services,
                title: 'Operating Rooms',
                onTap:
                    () => Navigator.pushNamed(context, OperationRoomsScreen.id),
              ),
              _buildDrawerItem(
                icon: Icons.bed,
                title: 'Patient Rooms',
                onTap:
                    () => Navigator.pushNamed(context, PatientRoomsScreen.id),
              ),
                Divider(color: Colors.white70, height: 1.h),
              _buildDrawerItem(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () => Navigator.pushNamed(context, AboutScreen.id),
              ),
              _buildDrawerItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap:
                    () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginPage.id,
                      (route) => false,
                    ),
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // Header Section with Date/Time
          Container(
            margin: EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 43, 198, 175),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome Dr. ${username}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      DateFormat('EEEE, MMMM d, y').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      DateFormat('h:mm a').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Quick Actions Section
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 25, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAction(
                  icon: Icons.add_circle_outline,
                  color: const Color(0xFF4CAF50),
                  label: 'New Booking',
                  onTap:
                      () =>
                          Navigator.pushNamed(context, Patient_information.id),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: _buildQuickAction(
                    icon: Icons.edit,
                    color: const Color(0xFF2196F3),
                    label: 'All Booking',
                    onTap:
                        () =>
                            Navigator.pushNamed(context, AllBookingsScreen.id),
                  ),
                ),
                _buildQuickAction(
                  icon: Icons.check_circle,
                  color: const Color(0xFF9C27B0),
                  label: 'completed operation',
                  onTap:
                      () => Navigator.pushNamed(
                        context,
                        ConfirmedBookingsScreen.id,
                      ),
                ),
              ],
            ),
          ),
          // News and Alerts Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Hospital News & Alerts',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F51B5),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: news.length,
              itemBuilder: (context, index) {
                final newsItem = news[index];
                return _buildNewsCard(newsItem);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      dense: true,
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> newsItem) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: getBackgroundColor(newsItem['type']),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: getColor(newsItem['type']).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    getIcon(newsItem['type']),
                    color: getColor(newsItem['type']),
                    size: 20,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    newsItem['title'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(newsItem['content'], style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
