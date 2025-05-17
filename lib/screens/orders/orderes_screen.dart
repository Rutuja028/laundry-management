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
        title: const Text('Orders', style: TextStyle(color: Colors.teal)),
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
          final orders = orderController.orders;

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                "No invoices available.",
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
              final status = order['status'] ?? 'pending';
              final orderId = order['orderId'] ?? 'Unknown';

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
                color: Colors.white,
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
                        "Customer: $customerName",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Phone: $customerPhone",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Address: $customerAddress",
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
                        "Pickup: $pickupDate at $pickupTime",
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Delivery: $deliveryDate at $deliveryTime",
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

                      if (status != 'delivered')
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onPressed: () async {
                                Get.dialog(
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  barrierDismissible: false,
                                );

                                await orderController.updateOrderStatus(
                                  customerPhone: customerPhone,
                                  orderId: orderId,
                                  status: 'delivered',
                                );

                                Get.back();

                                Get.snackbar(
                                  "Success",
                                  "Order marked as delivered",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              child: const Text(
                                'Mark as Delivered',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
