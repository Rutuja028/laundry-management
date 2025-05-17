import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/delivered_controller.dart';
import 'package:shimmer/shimmer.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  DeliveredOrdersScreen({super.key});

  final DeliveryController deliveryController = Get.find<DeliveryController>();

  @override
  Widget build(BuildContext context) {
    deliveryController.fetchdeliveredOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivered Orders',
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: const Color(0xFFE0F2F1),
        iconTheme: const IconThemeData(color: Colors.teal),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFE0F2F1),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F2F1), Color(0xFF80CBC4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          if (deliveryController.isLoading.value) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: 6,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
              ),
            );
          }
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
                color: Colors.white,
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
                          color: Colors.teal,
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
