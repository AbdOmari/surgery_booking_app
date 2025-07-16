import 'package:final_project_ypu/AboutScreen%20.dart';
import 'package:final_project_ypu/AppointmentSummaryScreen%20.dart';
import 'package:final_project_ypu/BookingPatientRoomsScreen.dart';
import 'package:final_project_ypu/Booking_scree.dart';
import 'package:final_project_ypu/ConfirmedBookingsScreen.dart';
import 'package:final_project_ypu/HomePage.dart';
import 'package:final_project_ypu/LogIn.dart';
import 'package:final_project_ypu/OperationRoomsScreen.dart';
import 'package:final_project_ypu/PatientRoomsScreen.dart';
import 'package:final_project_ypu/Patient_information.dart';
import 'package:final_project_ypu/all_bookings_screen.dart';
import 'package:final_project_ypu/editbooking.dart';
import 'package:final_project_ypu/finaleditbooking.dart';
import 'package:final_project_ypu/operation_booking.dart';
import 'package:final_project_ypu/profile_doctor.dart';
import 'package:final_project_ypu/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project_ypu/BookingOperationRoomsScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Hive
  await Hive.initFlutter();

  // تسجيل الـ Adapter
  Hive.registerAdapter(OperationBookingAdapter());

  // فتح صناديق التخزين
  await Hive.openBox<OperationBooking>('bookings');
  await Hive.openBox<OperationBooking>('confirmedBookings');
  await Hive.openBox('userBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // المقاس الأصلي للتصميم
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'My Appointment App',
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(
                  1.0,
                ), // ⬅️ هذا هو السطر المهم
              ),
              child: widget!,
            );
          },

          home: SplashScreen(),
          routes: {
            HomePage.id: (context) {
              final args =
                  ModalRoute.of(context)?.settings.arguments
                      as Map<String, dynamic>?;
              return HomePage(); // يمكنك استخدام args إذا احتجت
            },
            LoginPage.id: (context) => LoginPage(),
            Patient_information.id: (context) => Patient_information(),
            DoctorProfileScreen.id: (context) => DoctorProfileScreen(),
            AppointmentBookingScreen.id:
                (context) => const AppointmentBookingScreen(),
            OperationRoomsScreen.id: (context) => OperationRoomsScreen(),
            AllBookingsScreen.id: (context) => AllBookingsScreen(),
            ConfirmedBookingsScreen.id:
                (context) => const ConfirmedBookingsScreen(),
            AboutScreen.id: (context) => AboutScreen(),
            PatientRoomsScreen.id: (context) => PatientRoomsScreen(),
            AppointmentSummaryScreen.id:
                (context) => AppointmentSummaryScreen(
                  name: '',
                  phone: '',
                  age: '',
                  gender: '',
                  selectedDate: '',
                  selectedTime: '',
                  operationRoomName: '',
                  patientRoomName: '',
                ),
          },
        );
      },
    );
  }
}
