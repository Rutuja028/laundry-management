import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/screens/items/add_item_count.dart';
import 'package:laundry_management/screens/items/order_summary.dart';

class ScheduleDateTime extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;
  ScheduleDateTime({super.key, required this.selectedItems});

  final ItemController controller = Get.find<ItemController>();

  final List<String> timeSlots = [
    '8 AM - 10 AM',
    '10 AM - 1 PM',
    '1 PM - 3 PM',
    '3 PM - 5 PM',
    '5 PM - 7 PM',
    '7 PM - 9 PM',
  ];

  String _getMonth(int month) =>
      const [
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
      ][month - 1];

  String _getWeekday(int weekday) =>
      const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][weekday - 1];

  String getFormattedDate(DateTime date) =>
      "${_getWeekday(date.weekday)}, ${date.day} ${_getMonth(date.month)} ${date.year}";

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      String formattedDate = getFormattedDate(picked);
      if (isPickup) {
        controller.setPickupDate(formattedDate);
      } else {
        controller.setDeliveryDate(formattedDate);
      }
    }
  }

  Widget buildTimeSlot({
    required String time,
    required RxString selectedTime,
    required VoidCallback onTap,
  }) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selectedTime.value == time ? Colors.teal : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selectedTime.value == time ? Colors.teal : Colors.grey,
            ),
          ),
          child: Text(
            time,
            style: TextStyle(
              color: selectedTime.value == time ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        title: const Text('Add Items'),
        backgroundColor: const Color(0xFF80CBC4),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Schedule Pickup",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Date", style: TextStyle(color: Colors.black87)),
              Obx(
                () => GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Center(
                      child: Text(
                        controller.pickupDate.value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Text("Time", style: TextStyle(color: Colors.black87)),
              Wrap(
                children:
                    timeSlots
                        .map(
                          (time) => buildTimeSlot(
                            time: time,
                            selectedTime: controller.pickupTime,
                            onTap: () => controller.setPickupTime(time),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 20),
              const Text(
                "Schedule Delivery",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 10),
              const Text("Date", style: TextStyle(color: Colors.black87)),
              Obx(
                () => GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Center(
                      child: Text(
                        controller.deliveryDate.value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Text("Time", style: TextStyle(color: Colors.black87)),
              Wrap(
                children:
                    timeSlots
                        .map(
                          (time) => buildTimeSlot(
                            time: time,
                            selectedTime: controller.deliveryTime,
                            onTap: () => controller.setDeliveryTime(time),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(color: Colors.teal),
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (selectedItems.isEmpty ||
                    controller.pickupDate.value.isEmpty ||
                    controller.deliveryDate.value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please complete all details'),
                    ),
                  );
                  return;
                }

                Get.to(() => OrderSummary());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
