import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_project_ypu/HomePage.dart';
import 'operation_booking.dart'; // تأكد من وجود هذا الملف

class AppointmentSummaryScreen extends StatelessWidget {
  static const String id = "AppointmentSummaryScreen";

  final String name;
  final String phone;
  final String age;
  final String gender;
  final String selectedDate;
  final String selectedTime;
  final String operationRoomName;
  final String patientRoomName;

  const AppointmentSummaryScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
    required this.selectedDate,
    required this.selectedTime,
    required this.operationRoomName,
    required this.patientRoomName,
  }) : super(key: key);

  void _saveBooking(BuildContext context) async {
    try {
      final booking = OperationBooking(
        name: name,
        phone: phone,
        age: age,
        gender: gender,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        operationRoomName: operationRoomName,
        patientRoomName: patientRoomName,
      );

      final bookingsBox = Hive.box<OperationBooking>('bookings');
      await bookingsBox.add(booking);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم حفظ الحجز بنجاح!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('حدث خطأ أثناء الحفظ: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'ملخص الحجز',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.id,
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveBooking(context),
            tooltip: 'حفظ الحجز',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoCard(
              title: 'معلومات المريض',
              icon: Icons.person,
              color: Colors.blue,
              children: [
                _buildInfoItem('الاسم الكامل', name),
                _buildInfoItem('رقم الهاتف', phone),
                _buildInfoItem('العمر', '$age سنة'),
                _buildInfoItem('الجنس', gender),
              ],
            ),

            SizedBox(height: 20.h),

            _buildInfoCard(
              title: 'تفاصيل الموعد',
              icon: Icons.calendar_today,
              color: Colors.green,
              children: [
                _buildInfoItem('التاريخ', selectedDate),
                _buildInfoItem('الوقت', selectedTime),
                _buildInfoItem('غرفة العمليات', operationRoomName),
                _buildInfoItem('غرفة المريض', patientRoomName),
              ],
            ),

            SizedBox(height: 30.h),

            // زر إضافي للحفظ في أسفل الصفحة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                onPressed: () => _saveBooking(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save, size: 24),
                    SizedBox(width: 10.w),
                    Text('حفظ الحجز', style: TextStyle(fontSize: 16.sp)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
