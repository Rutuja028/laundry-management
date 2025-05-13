import 'package:flutter/material.dart';
import 'package:laundry_management/screens/add_item_count.dart';
import 'package:laundry_management/screens/order_summary.dart';

class ScheduleDateTime extends StatefulWidget {
  const ScheduleDateTime({super.key});

  @override
  _ScheduleDateTimeState createState() => _ScheduleDateTimeState();
}

class _ScheduleDateTimeState extends State<ScheduleDateTime> {
  String selectedPickupTime = '8 AM - 10 AM';
  String selectedDeliveryTime = '8 AM - 10 AM';
  String? pickupDate = 'Wed, 4 Dec 2024';
  String? deliveryDate;

  // List of Time Slots
  final List<String> timeSlots = [
    '8 AM - 10 AM',
    '10 AM - 1 PM',
    '1 PM - 3 PM',
    '3 PM - 5 PM',
    '5 PM - 7 PM',
    '7 PM - 9 PM',
  ];

  // Date picker function
  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        String formattedDate =
            "${picked.weekday}, ${picked.day} ${_getMonth(picked.month)} ${picked.year}";
        if (isPickup) {
          pickupDate = formattedDate;
        } else {
          deliveryDate = formattedDate;
        }
      });
    }
  }

  // Helper function to get month name
  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  // Time Slot Widget
  Widget buildTimeSlot({
    required String time,
    required String selectedTime,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selectedTime == time ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black54),
        ),
        child: Text(
          time,
          style: TextStyle(
            color: selectedTime == time ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA0D8F0),
      appBar: AppBar(
        title: const Text('Add Items'),
        backgroundColor: const Color(0xFFA0D8F0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Schedule Pickup
              const Text(
                "Schedule Pickup",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Date (Current)"),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      pickupDate ?? 'Select Date',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
              const Text("Time"),
              Wrap(
                children:
                    timeSlots.map((time) {
                      return buildTimeSlot(
                        time: time,
                        selectedTime: selectedPickupTime,
                        onTap: () {
                          setState(() {
                            selectedPickupTime = time;
                          });
                        },
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              // Schedule Delivery
              const Text(
                "Schedule Delivery",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text("Date"),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      deliveryDate ?? 'Select Date',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
              const Text("Time"),
              Wrap(
                children:
                    timeSlots.map((time) {
                      return buildTimeSlot(
                        time: time,
                        selectedTime: selectedDeliveryTime,
                        onTap: () {
                          setState(() {
                            selectedDeliveryTime = time;
                          });
                        },
                      );
                    }).toList(),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddItemCount(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderSummary()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
