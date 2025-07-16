import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'operation_booking.dart';
import 'HomePage.dart';
import 'ConfirmedBookingsScreen.dart';

class AllBookingsScreen extends StatelessWidget {
  static const String id = "AllBookingsScreen";

  const AllBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3F51B5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white, // ← هنا تحدد لون الزر
          onPressed: () {
            Navigator.pop(context); // أو أي تنقل آخر حسب ما تريد
          },
        ),
        title: Text('All Operations', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomePage.id,
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<OperationBooking>('bookings').listenable(),
        builder: (context, Box<OperationBooking> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No bookings found'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final booking = box.getAt(index);
              return Card(
                color: const Color.fromARGB(255, 202, 217, 255),
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ExpansionTile(
                  title: Text(
                    booking!.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  subtitle: Text(
                    '${booking.selectedDate} - ${booking.selectedTime}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow('📞 Phone', booking.phone),
                          _buildInfoRow('🎂 Age', booking.age),
                          _buildInfoRow('🚻 Gender', booking.gender),
                          _buildInfoRow(
                            '🏥 Operation Room',
                            booking.operationRoomName,
                          ),
                          _buildInfoRow(
                            '🛏️ Patient Room',
                            booking.patientRoomName,
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    192,
                                    63,
                                    63,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed:
                                    () =>
                                        _showDeleteDialog(context, box, index),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    63,
                                    204,
                                    58,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Done',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed:
                                    () => _showConfirmDialog(
                                      context,
                                      booking,
                                      index,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    Box<OperationBooking> box,
    int index,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Delete Booking'),
            content: Text('Are you sure you want to delete this booking?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  box.deleteAt(index);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Operation successful'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  void _showConfirmDialog(
    BuildContext context,
    OperationBooking booking,
    int index,
  ) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Confirm Booking'),
            content: Text('Are you sure you want to confirm this booking?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  final confirmedBox = await Hive.openBox<OperationBooking>(
                    'confirmedBookings',
                  );
                  await confirmedBox.add(booking);
                  final bookingBox = Hive.box<OperationBooking>('bookings');
                  bookingBox.deleteAt(index);

                  Navigator.pop(context); // close dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Operation successful'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushNamed(context, ConfirmedBookingsScreen.id);
                },
                child: Text('Confirm', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
    );
  }
}
