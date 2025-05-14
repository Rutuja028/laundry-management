import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/order_controller.dart';

class InvoicesScreen extends StatelessWidget {
  InvoicesScreen({super.key});

  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: Colors.lightBlue,
      ),
      backgroundColor: Colors.lightBlue.shade100,
      body: Obx(() {
        final orders = orderController.orders;

        if (orders.isEmpty) {
          return const Center(child: Text("No invoices available."));
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
                      "Invoice #${index + 1}",
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
