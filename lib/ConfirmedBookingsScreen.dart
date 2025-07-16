import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'operation_booking.dart';
import 'HomePage.dart';

class ConfirmedBookingsScreen extends StatelessWidget {
  static const String id = "ConfirmedBookingsScreen";

  const ConfirmedBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmed Bookings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 71, 93, 203),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable:
            Hive.box<OperationBooking>('confirmedBookings').listenable(),
        builder: (context, Box<OperationBooking> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No confirmed bookings.'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final booking = box.getAt(index);
              return Card(
                color: Colors.blue.shade50,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(booking!.name),

                  subtitle: Text(
                    '${booking.selectedDate} - ${booking.selectedTime}',
                  ),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
