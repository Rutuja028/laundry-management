import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/routes/routes.dart';

class ScheduleDateTime extends StatelessWidget {
  ScheduleDateTime({super.key});

  final ItemController controller = Get.find<ItemController>();

  final List<String> timeSlots = [
    '8 AM - 10 AM',
    '10 AM - 1 PM',
    '1 PM - 3 PM',
    '3 PM - 5 PM',
    '5 PM - 7 PM',
    '7 PM - 9 PM',
  ];

  List<DateTime> _generateNext7Days() {
    return List.generate(
      7,
      (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  String _formatDay(DateTime date) =>
      ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  String _formatMonth(DateTime date) =>
      [
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
      ][date.month - 1];
  String _formatFullDate(DateTime date) =>
      "${_formatDay(date)}, ${date.day} ${_formatMonth(date)} ${date.year}";

  Widget _buildDateCard({
    required DateTime date,
    required RxString selectedDate,
    required void Function(String) onSelect,
  }) {
    String formattedDate = _formatFullDate(date);
    bool isSelected = selectedDate.value == formattedDate;

    return GestureDetector(
      onTap: () => onSelect(formattedDate),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              _formatDay(date),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${date.day} ${_formatMonth(date)}',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedItems = Get.arguments;
    final upcomingDates = _generateNext7Days();

    return Scaffold(
      backgroundColor: const Color(0xFFF1FDFB),
      appBar: AppBar(
        title: const Text('Schedule Service'),
        backgroundColor: const Color(0xFF00796B),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "📦 Pickup Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Pickup Date",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        upcomingDates
                            .map(
                              (date) => _buildDateCard(
                                date: date,
                                selectedDate: controller.pickupDate,
                                onSelect: controller.setPickupDate,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Pickup Time",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
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
              const SizedBox(height: 28),
              const Text(
                "🚚 Delivery Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Delivery Date",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        upcomingDates
                            .map(
                              (date) => _buildDateCard(
                                date: date,
                                selectedDate: controller.deliveryDate,
                                onSelect: controller.setDeliveryDate,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Delivery Time",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
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
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.teal),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
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
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.pickupDate.value.isEmpty ||
                      controller.deliveryDate.value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete all details'),
                      ),
                    );
                    return;
                  }
                  Get.toNamed(Routes.ordersummary, arguments: selectedItems);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
      ),
    );
  }

  Widget buildTimeSlot({
    required String time,
    required RxString selectedTime,
    required VoidCallback onTap,
  }) {
    return Obx(
      () => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selectedTime.value == time ? Colors.teal : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  selectedTime.value == time
                      ? Colors.teal
                      : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            time,
            style: TextStyle(
              color: selectedTime.value == time ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
