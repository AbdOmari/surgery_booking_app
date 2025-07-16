import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class DoctorProfileScreen extends StatelessWidget {
  static const String id = "DoctorProfileScreen";

  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(
        body: Center(child: Text("لم يتم إرسال بيانات المستخدم")),
      );
    }
    final box = Hive.box('userBox');
    final username = box.get('username', defaultValue: 'Guest');
    final password = box.get('password', defaultValue: '');
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final doctorData = {
      'imageUrl': 'https://www.w3schools.com/howto/img_avatar.png',
      'id': '015684',
      'name': 'Dr. $username',
      'password': password,
      'phone': '+966 564 360 686',
      'specialization': 'Heart Surgery Specialist',
      'experience': '0 Years',
      'education': 'MD, Harvard Medical School',
      'updatedAt': formattedDate,
      'email': '$username@gemail.com',
    };

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple[800],
        elevation: 0,
        title: Text(
          'My Profile',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.edit, color: Colors.white),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.deepPurple[800],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          // Profile Card
          Transform.translate(
            offset: const Offset(0, -60),
            child: Center(
              child: Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(doctorData['imageUrl']!),
                ),
              ),
            ),
          ),

          // Doctor Name and Specialization
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              doctorData['name']!,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            doctorData['specialization']!,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.deepPurple[600],
              fontWeight: FontWeight.w500,
            ),
          ),

          // Rating and Experience
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRatingBadge(Icons.star, '0'),
                SizedBox(width: 20.w),
                _buildRatingBadge(Icons.work, doctorData['experience']!),
                SizedBox(width: 20.w),
                _buildRatingBadge(Icons.school, 'Dr'),
              ],
            ),
          ),

          // Details Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildDetailItem(
                          Icons.person_outline,
                          'Doctor ID',
                          doctorData['id']!,
                        ),
                        // const Divider(height: 20.h),
                        // _buildDetailItem(
                        //   Icons.phone_android_outlined,
                        //   'Phone',
                        //   doctorData['phone']!,
                        // ),
                          Divider(height: 20.h),
                        _buildDetailItem(
                          Icons.email_outlined,
                          'Email',
                          doctorData['email']!,
                        ),
                          Divider(height: 20.h),
                        _buildDetailItem(
                          Icons.lock_outline,
                          'Password',
                          ' $password',
                        ),
                          Divider(height: 20.h),
                        _buildDetailItem(
                          Icons.calendar_today_outlined,
                          'Last Updated',
                          doctorData['updatedAt']!,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Footer Buttons
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.deepPurple[800],
          //             padding: const EdgeInsets.symmetric(vertical: 16),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //           ),
          //           onPressed: () {},
          //           child: Text(
          //             'Edit Profile',
          //             style: TextStyle(
          //               fontSize: 16.sp,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(width: 16.w),
          //       Expanded(
          //         child: OutlinedButton(
          //           style: OutlinedButton.styleFrom(
          //             padding: const EdgeInsets.symmetric(vertical: 16),
          //             side: BorderSide(color: Colors.deepPurple[800]!),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //           ),
          //           onPressed: () {},
          //           child: Text(
          //             'Share',
          //             style: TextStyle(
          //               fontSize: 16.sp,
          //               fontWeight: FontWeight.bold,
          //               color: Colors.deepPurple[800],
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildRatingBadge(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.deepPurple[800]),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple[800]),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.sp.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DoctorProfileScreen extends StatelessWidget {
//   static const String id = "DoctorProfileScreen";

//   const DoctorProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final args =
//         ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

//     // إذا كانت البيانات null نعرض رسالة تنبيه
//     if (args == null) {
//       return const Scaffold(
//         body: Center(child: Text("لم يتم إرسال بيانات المستخدم.")),
//       );
//     }

//     final String username =
//         args['username'] ?? 'Unknown User'; // استلام اسم المستخدم
//     final String password =
//         args['password'] ?? 'No Password'; // استلام كلمة المرور
//     String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

//     final doctorData = {
//       'imageUrl': 'https://www.w3schools.com/howto/img_avatar.png',
//       'id': '202110190',
//       'name': 'D. $username', // دمج اسم المستخدم مع 'D.' لعرضه في الملف الشخصي
//       'password':
//           ' $password', // عرض كلمة المرور (يمكنك تعديل هذا إذا كنت لا تريد عرضها)
//       'phone': '0964360686',
//       'specialization': 'Heart surgery',
//       'updatedAt': formattedDate,
//     };

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 109, 104, 249),
//         title: Text(
//           'Doctor Profile',
//           style: TextStyle(fontSize: 25.sp, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Center(
//                   child: CircleAvatar(
//                     radius: 80.0,
//                     backgroundImage: NetworkImage(doctorData['imageUrl']!),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Text(
//                   doctorData['name']!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 24.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 10.h),
//                 Text(
//                   doctorData['specialization']!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18.sp, color: Colors.grey[600]),
//                 ),
//                 SizedBox(height: 20.h),
//                 _buildInfoTile(Icons.person, 'ID:', doctorData['id']!),
//                 _buildInfoTile(
//                   Icons.email,
//                   'Email:',
//                   '$username@gmail.com',
//                 ), // عرض البريد الإلكتروني بناءً على اسم المستخدم
//                 // _buildInfoTile(Icons.phone, 'Phone:', doctorData['phone']!),
//                 // _buildInfoTile(
//                 //   Icons.calendar_today,
//                 //   'Created At:',
//                 //   doctorData['createdAt']!,
//                 // ),
//                 _buildInfoTile(
//                   Icons.update,
//                   'Updated At:',
//                   doctorData['updatedAt']!,
//                 ),
//                 // SizedBox(height: 20.h),
//                 _buildInfoTile(
//                   Icons.lock,
//                   'Password:',
//                   doctorData['password']!,
//                 ), // عرض كلمة المرور (يمكنك إخفاءها إذا رغبت)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoTile(IconData icon, String label, String value) {
//     return ListTile(
//       leading: Icon(icon, color: const Color.fromARGB(255, 109, 104, 249)),
//       title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//       subtitle: Text(value),
//     );
//   }
// }
