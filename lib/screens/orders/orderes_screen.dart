import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/order_controller.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final OrderController orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
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
            final status =
                order['status'] ?? 'pending'; // Default status if none
            final orderId =
                order['orderId'] ??
                'Unknown'; // Provide a default value if orderId is null

            final customerName = customer['name'] ?? 'Unknown';
            final customerPhone = customer['phone'] ?? 'Unknown';
            final customerAddress = customer['address'] ?? 'Unknown';
            final pickupDate = pickup['date'] ?? 'Not specified';
            final pickupTime = pickup['time'] ?? 'Not specified';
            final deliveryDate = delivery['date'] ?? 'Not specified';
            final deliveryTime = delivery['time'] ?? 'Not specified';

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
                    Text("Customer: $customerName"),
                    Text("Phone: $customerPhone"),
                    Text("Address: $customerAddress"),
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
                    Text("Pickup: $pickupDate at $pickupTime"),
                    Text("Delivery: $deliveryDate at $deliveryTime"),
                    const Divider(height: 20),
                    Text("Total: ₹${order['subtotal']}"),
                    const SizedBox(height: 12),

                    // Status text
                    Text(
                      "Status: ${status[0].toUpperCase() + status.substring(1)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            status == 'delivered'
                                ? Colors.green
                                : Colors.orange,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Show button only if not delivered
                    if (status != 'delivered')
                      ElevatedButton(
                        onPressed: () async {
                          Get.dialog(
                            Center(child: CircularProgressIndicator()),
                            barrierDismissible: false,
                          );

                          await orderController.updateOrderStatus(
                            customerPhone: customerPhone,
                            orderId: orderId,
                            status: 'delivered',
                          );

                          Get.back(); // close loading dialog

                          Get.snackbar(
                            "Success",
                            "Order marked as delivered",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                        child: const Text('Mark as Delivered'),
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
