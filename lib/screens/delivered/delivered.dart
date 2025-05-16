import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/delivered_controller.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  DeliveredOrdersScreen({super.key});

  final DeliveryController deliveryController = Get.find<DeliveryController>();

  @override
  Widget build(BuildContext context) {
    // Fetch delivered orders when the screen builds
    deliveryController.fetchdeliveredOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivered Orders',
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: const Color(0xFFE0F2F1), // OTP light teal
        iconTheme: const IconThemeData(color: Colors.teal),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFE0F2F1), // OTP light teal background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0F2F1), // OTP gradient start
              Color(0xFF80CBC4), // OTP gradient end
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          final orders = deliveryController.orders;

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "No delivered orders available.",
                style: TextStyle(color: Colors.teal),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final customer = order['customer'];
              final items = order['items'] as List;
              final pickup = order['pickup'];
              final delivery = order['delivery'];
              final timestamp = order['timestamp'];
              final orderId = order['orderId'];
              final customerPhone = customer['phone'];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white, // keep card white for readability
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${index + 1}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal, // OTP theme accent color
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Date: ${DateTime.parse(timestamp).toLocal()}",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Customer: ${customer['name']}",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Phone: ${customer['phone']}",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Address: ${customer['address']}",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const Divider(height: 20),
                      const Text(
                        "Items",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "- ${item['name']} x ${item['quantity']} = ₹${item['price'] * item['quantity']}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                      const Divider(height: 20),
                      Text(
                        "Pickup: ${pickup['date']} at ${pickup['time']}",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Delivery: ${delivery['date']} at ${delivery['time']}",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      const Divider(height: 20),
                      Text(
                        "Total: ₹${order['subtotal']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Status text (always delivered here)
                      const Text(
                        "Status: Delivered",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
