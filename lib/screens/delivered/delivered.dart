import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/delivered_controller.dart';
import 'package:laundry_management/controllers/order_controller.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  DeliveredOrdersScreen({super.key});

  final DeliveryController deliveryController = Get.find<DeliveryController>();

  @override
  Widget build(BuildContext context) {
    // Fetch delivered orders when the screen builds
    deliveryController.fetchdeliveredOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivered Orders'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.lightBlue.shade100,
      body: Obx(() {
        final orders = deliveryController.orders;

        if (orders.isEmpty) {
          return const Center(child: Text("No delivered orders available."));
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
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text("Date: ${DateTime.parse(timestamp).toLocal()}"),
                    const SizedBox(height: 6),
                    Text("Customer: ${customer['name']}"),
                    Text("Phone: ${customer['phone']}"),
                    Text("Address: ${customer['address']}"),
                    const Divider(height: 20),
                    const Text(
                      "Items",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "- ${item['name']} x ${item['quantity']} = ₹${item['price'] * item['quantity']}",
                        ),
                      ),
                    ),
                    const Divider(height: 20),
                    Text("Pickup: ${pickup['date']} at ${pickup['time']}"),
                    Text(
                      "Delivery: ${delivery['date']} at ${delivery['time']}",
                    ),
                    const Divider(height: 20),
                    Text("Total: ₹${order['subtotal']}"),
                    const SizedBox(height: 12),
                    // Status text (always delivered here)
                    Text(
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
    );
  }
}
