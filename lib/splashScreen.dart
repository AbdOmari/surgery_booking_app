import 'package:final_project_ypu/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart'; // إضافة Lottie

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // الانتقال إلى الصفحة التالية بعد 3 ثوانٍ
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استخدام تدرج لوني باللون النهدي
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 222, 192, 255), // اللون الوردي الفاتح
              Color.fromARGB(255, 115, 115, 246), // اللون الوردي الداكن
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // توسيط المحتويات عموديًا
            children: [
              // إضافة رسم متحرك باستخدام Lottie
              Lottie.asset(
                'assets/animations/Animation - 1738137048097.json', // مسار ملف Lottie
                width: 220.w, // تحديد العرض
                height: 220.h, // تحديد الارتفاع
                fit: BoxFit.fill, // كيفية ملء المساحة
              ),
              SizedBox(height: 30.h), // مسافة بين الرسوم المتحركة والنص
            ],
          ),
        ),
      ),
    );
  }
}















              // نص ترحيبي
              // Text(
              //   "Appointment App",
              //   style: TextStyle(
              //     fontSize: 28.sp, // حجم النص
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white, // لون النص
              //     fontFamily: 'Arial', // استخدام خط أكثر بساطة
              //     letterSpacing: 1.2, // إضافة مسافة بين الحروف
              //     shadows: [
              //       Shadow(
              //         blurRadius: 8.0, // تأثير الظل
              //         color: Colors.black.withOpacity(0.4), // تعديل كثافة الظل
              //         offset: Offset(2.0, 2.0), // تحريك الظل
              //       ),
              //     ],
              //   ),
              // ),
