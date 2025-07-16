import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  static String id = "AboutScreen";

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'abdabdabd437437437@gmail.com',
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }

  Future<void> _launchPhoneCall() async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: '+963964360686');
    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      throw 'Could not launch phone call';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // ← هنا تحدد لون الزر
          onPressed: () {
            Navigator.pop(context); // أو أي تنقل آخر حسب ما تريد
          },
        ),
        title: Text(
          'About App',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF3F51B5),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F5F5), Color(0xFFE8EAF6)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F51B5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.medical_services,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                SizedBox(height: 30.h),

                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildInfoItem(
                        icon: Icons.person,
                        title: 'Developer',
                        value: 'Eng Abdulrhman Alomri',
                      ),
                        Divider(height: 30.h, thickness: 0.5),

                      _buildInfoItem(
                        icon: Icons.email,
                        title: 'Email',
                        value: 'aboodsyrias24ultra@gmail.com',
                        isClickable: true,
                        onTap: _launchEmail,
                      ),
                        Divider(height: 30.h, thickness: 0.5),

                      _buildInfoItem(
                        icon: Icons.phone,
                        title: 'Phone',
                        value: '+963 964-360-686',
                        isClickable: true,
                        onTap: _launchPhoneCall,
                      ),
                        Divider(height: 30.h, thickness: 0.5),

                      _buildInfoItem(
                        icon: Icons.info,
                        title: 'App Version',
                        value: '1.0.0',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                Text(
                  '© 2025 All Rights Reserved',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: isClickable ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF3F51B5)),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    value,
                    style: TextStyle(
                      color:
                          isClickable ? const Color(0xFF3F51B5) : Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (isClickable)
              const Icon(Icons.chevron_left, color: Color(0xFF3F51B5)),
          ],
        ),
      ),
    );
  }
}
