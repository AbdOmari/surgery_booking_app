import 'package:final_project_ypu/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AppointmentBookingScreen extends StatefulWidget {
  static const String id = "AppointmentBookingScreen";
  final Appointment? appointment; // استقبال الموعد كـ parameter

  const AppointmentBookingScreen({Key? key, this.appointment})
    : super(key: key);

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  int _selectedButtonIndex = 0;
  Appointment? _editingAppointment;
  final TextEditingController _patientNameController = TextEditingController();
  final List<String> _times = [
    '08:00 AM',
    '10:00 AM',
    '12:00 PM',
    '02:00 PM',
    '04:00 PM',
    '06:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    _editingAppointment =
        widget
            .appointment; // تهيئة _editingAppointment باستخدام widget.appointment
    if (_editingAppointment != null) {
      _selectedDay = _editingAppointment!.dateTime;
      final timeFormat = DateFormat('hh:mm a');
      _selectedTime = timeFormat.format(_editingAppointment!.dateTime);
      _selectedButtonIndex = _times.indexOf(_selectedTime!) + 1;
      _patientNameController.text = _editingAppointment!.patientName;
      _focusedDay = _selectedDay!;
    }
  }

  Widget _buildTimeButton(String time, int index) {
    bool isSelected = _selectedButtonIndex == index + 1;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedButtonIndex = index + 1;
          _selectedTime = time;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2196F3) : Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey[300]!, width: 1.5.w),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAppointmentConfirmationDialog(
    BuildContext context,
    Appointment updatedAppointment,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('An appointment has been booked'),
          content: Text('Your appointment has been booked successfully'),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context, updatedAppointment);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: Text(
          _editingAppointment == null
              ? 'Book a new appointment'
              : 'Modify an appointment',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Choose the date",
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.h),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TableCalendar(
                      focusedDay: _focusedDay,
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2030, 12, 31),
                      selectedDayPredicate:
                          (day) => isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!selectedDay.isBefore(DateTime.now())) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        }
                      },
                      enabledDayPredicate:
                          (day) => !day.isBefore(DateTime.now()),
                      calendarStyle: CalendarStyle(
                        selectedDecoration: const BoxDecoration(
                          color: Color(0xFF2196F3),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.blue[100],
                          shape: BoxShape.circle,
                        ),
                        defaultTextStyle: TextStyle(fontSize: 16.sp),
                        weekendTextStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 16.sp,
                        ),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                if (_selectedDay != null) ...[
                  Text(
                    "Choose the time",
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: List.generate(
                      _times.length,
                      (index) => _buildTimeButton(_times[index], index),
                    ), // تم التعديل هنا
                  ),
                ],
                SizedBox(height: 40.h),
                if (_selectedDay != null && _selectedTime != null)
                  ElevatedButton(
                    onPressed: () async {
                      final selectedDateTime = DateTime(
                        _selectedDay!.year,
                        _selectedDay!.month,
                        _selectedDay!.day,
                        int.parse(_selectedTime!.split(':')[0]),
                        int.parse(_selectedTime!.split(':')[1].substring(0, 2)),
                      );

                      final updatedAppointment = Appointment(
                        dateTime: selectedDateTime,
                        operatingRoom: 'Room 1',
                        patientName: _patientNameController.text,
                        patientRoom: '',
                      );

                      if (_editingAppointment == null) {
                        await _showAppointmentConfirmationDialog(
                          context,
                          updatedAppointment,
                        );
                      } else {
                        Navigator.pop(context, updatedAppointment);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 18.sp),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Booking confirmation',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
