import 'package:final_project_ypu/all_bookings_screen.dart';
import 'package:final_project_ypu/operation_booking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_project_ypu/HomePage.dart';

class DoctorAppointmentManagementScreen2 extends StatefulWidget {
  static const String id = "DoctorAppointmentManagementScreen2";

  final String name;
  final String phone;
  final String age;
  final String gender;
  final String selectedDate;
  final String selectedTime;
  final String operationRoomName;
  final String patientRoomName;

  const DoctorAppointmentManagementScreen2({
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

  @override
  _DoctorAppointmentManagementScreen2State createState() =>
      _DoctorAppointmentManagementScreen2State();
}

class _DoctorAppointmentManagementScreen2State
    extends State<DoctorAppointmentManagementScreen2> {
  Future<void> _saveBooking() async {
    try {
      final booking = OperationBooking(
        name: widget.name,
        phone: widget.phone,
        age: widget.age,
        gender: widget.gender,
        selectedDate: widget.selectedDate,
        selectedTime: widget.selectedTime,
        patientRoomName: widget.operationRoomName,
        operationRoomName: widget.patientRoomName,
      );

      final box = Hive.box<OperationBooking>('bookings');
      await box.add(booking);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          closeIconColor: Colors.green,
          content: Text('Your reservation has been saved successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء الحفظ: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text("Confirm Booking"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Patient: ${widget.name}"),
              Text("Date: ${widget.selectedDate}"),
              Text("Time: ${widget.selectedTime}"),
              SizedBox(height: 16.h),
              Text("Are you sure you want to confirm this reservation?"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pop(context);
                _saveBooking();
              },
              child: Text("Confirm", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.id,
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue[800],
          title: Text(
            "Booking details",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
              color: Colors.blue[900],
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, size: 28),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildPatientHeader(
                  name: widget.name,
                  phone: widget.phone,
                  gender: widget.gender,
                  avatarColor: Colors.blue[50]!,
                ),

                _buildAppointmentDetails(
                  date: widget.selectedDate,
                  time: widget.selectedTime,
                  operationRoom: widget.operationRoomName,
                  patientRoom: widget.patientRoomName,
                ),

                _buildPatientInfo(phone: widget.phone, age: widget.age),
                SizedBox(height: 20.h),

                Divider(
                  color: Colors.grey,
                  height: 1.h,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30,
                  ),
                  child: ElevatedButton(
                    onPressed: () => _showConfirmationDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      shadowColor: Colors.green.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, size: 24),
                        SizedBox(width: 10.w),
                        Text(
                          'Confirm Booking',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientHeader({
    required String name,
    required String phone,
    required String gender,
    required Color avatarColor,
  }) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: avatarColor,
              border: Border.all(
                color: avatarColor.withOpacity(0.5),
                width: 2.w,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person_outline,
                size: 40,
                color: Colors.blue[600],
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "ID: #${phone.substring(phone.length - 4)}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    gender,
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetails({
    required String date,
    required String time,
    required String operationRoom,
    required String patientRoom,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Appointment details",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 20.h),
              _buildDetailRow(
                icon: Icons.calendar_today_outlined,
                title: "Date",
                value: date,
                iconColor: Colors.purple[600]!,
              ),
              _buildDivider(),
              _buildDetailRow(
                icon: Icons.access_time_rounded,
                title: "Time",
                value: time,
                iconColor: Colors.orange[600]!,
              ),
              _buildDivider(),
              _buildDetailRow(
                icon: Icons.medical_services_outlined,
                title: "Operation Room",
                value: operationRoom,
                iconColor: Colors.red[400]!,
              ),
              _buildDivider(),
              _buildDetailRow(
                icon: Icons.king_bed_outlined,
                title: "Patient Room",
                value: patientRoom,
                iconColor: Colors.teal[400]!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfo({required String phone, required String age}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Patient information",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 20.h),
              _buildDetailRow(
                icon: Icons.phone_iphone_rounded,
                title: "phone",
                value: phone,
                iconColor: Colors.blue[400]!,
              ),
              _buildDivider(),
              _buildDetailRow(
                icon: Icons.cake_outlined,
                title: "Age",
                value: "$age years",
                iconColor: Colors.pink[400]!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Divider(height: 1.h, color: Colors.grey[200]),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(icon, color: iconColor, size: 20)),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
