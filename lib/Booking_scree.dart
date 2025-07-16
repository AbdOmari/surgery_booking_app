import 'package:final_project_ypu/BookingOperationRoomsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Patient_Booking extends StatefulWidget {
  final String name;
  final String phone;
  final String age;
  final String gender;

  static const String id = "Patient_Booking";

  Patient_Booking({
    Key? key,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
  }) : super(key: key);

  @override
  State<Patient_Booking> createState() => _Patient_BookingState();
}

class _Patient_BookingState extends State<Patient_Booking> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? _selectedTime;
  int _selectedButtonIndex = 0;

  final List<String> _times = ['08:00 AM', '10:00 AM', '12:00 PM', '02:00 PM'];

  Widget _buildTimeButton(String time, int index) {
    bool isSelected = _selectedButtonIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedButtonIndex = index;
          _selectedTime = time;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3F51B5) : Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey[300]!, width: 15.w),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F51B5),
        title: Text(
          'Book a new appointment',
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
                          color: const Color(0xFF3F51B5),
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
                if (_selectedDay != null) ...[
                  SizedBox(height: 32.h),
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
                      (index) => _buildTimeButton(_times[index], index + 1),
                    ),
                  ),
                ],
                SizedBox(height: 40.h),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedDay == null || _selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select date and time'),
                        ),
                      );
                      return;
                    }

                    String formattedDate = DateFormat(
                      'yyyy-MM-dd',
                    ).format(_selectedDay!);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BookingOperationRoomsScreen(
                              name: widget.name,
                              phone: widget.phone,
                              age: widget.age,
                              gender: widget.gender,
                              selectedDate: formattedDate,
                              selectedTime: _selectedTime!,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51B5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Confirm your reservation',
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
