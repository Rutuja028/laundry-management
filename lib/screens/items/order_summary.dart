import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/customer_controller.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/controllers/order_controller.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  bool _showConfirmation = false;
  final OrderController orderController = Get.find<OrderController>();
  final CustomerController customerController = Get.find<CustomerController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE0F2F1), Color(0xFF80CBC4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: const Text(
                      'Order Summary',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    iconTheme: const IconThemeData(color: Colors.teal),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAddressSection(),
                          const SizedBox(height: 12),
                          _buildItemsSection(),
                          const SizedBox(height: 12),
                          _buildScheduleSection(),
                          const SizedBox(height: 12),
                          _buildBillDetailsSection(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.teal),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(color: Colors.teal),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _showConfirmation = true;
                            });

                            final ItemController itemController = Get.find();
                            final customer =
                                customerController.customerList.last;

                            int subtotal = 0;
                            final items = [];

                            for (
                              int i = 0;
                              i < itemController.items.length;
                              i++
                            ) {
                              final item = itemController.items[i];
                              final qty = itemController.quantities[i].value;

                              if (qty > 0) {
                                final price =
                                    int.tryParse(
                                      item['price'].toString().replaceAll(
                                        RegExp(r'[^\d]'),
                                        '',
                                      ),
                                    ) ??
                                    0;
                                subtotal += price * qty;

                                items.add({
                                  'name': item['name'],
                                  'quantity': qty,
                                  'price': price,
                                  'image': item['image'],
                                });
                              }
                            }

                            final order = {
                              'customer': customer,
                              'items': items,
                              'subtotal': subtotal,
                              'pickup': {
                                'date': itemController.pickupDate.value,
                                'time': itemController.pickupTime.value,
                              },
                              'delivery': {
                                'date': itemController.deliveryDate.value,
                                'time': itemController.deliveryTime.value,
                              },
                              'timestamp': DateTime.now().toIso8601String(),
                              'status': 'pending',
                            };

                            orderController.addOrder(order);

                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                _showConfirmation = false;
                              });
                              Get.toNamed('/home');
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.teal),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor: Colors.teal,
                          ),
                          child: const Text(
                            'Pay',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showConfirmation)
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: Colors.greenAccent,
                      size: 80,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Payment Confirmed!",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Obx(() {
      if (customerController.customerList.isEmpty) {
        return Card(
          color: Colors.teal.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "No customer details available.",
              style: TextStyle(color: Colors.teal),
            ),
          ),
        );
      }

      final customer = customerController.customerList.last;

      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    'Deliver to:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${customer['name']}\nPhone: ${customer['phone']}\nAddress: ${customer['address']}",
                style: const TextStyle(fontSize: 15, color: Colors.teal),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildItemsSection() {
    final ItemController controller = Get.find();

    return Obx(() {
      final List<Widget> itemCards = [];

      for (int i = 0; i < controller.items.length; i++) {
        if (controller.quantities[i].value > 0) {
          final item = controller.items[i];
          itemCards.add(
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              elevation: 4,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item['image'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  item['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                subtitle: Text(
                  '₹${item['price']} x ${controller.quantities[i].value} = ₹${(int.tryParse(item['price'].toString().replaceAll(RegExp(r'[^\d]'), '')) ?? 0) * controller.quantities[i].value}',
                  style: TextStyle(color: Colors.teal.shade700),
                ),
              ),
            ),
          );
        }
      }

      if (itemCards.isEmpty) {
        return const Text(
          "No items selected.",
          style: TextStyle(color: Colors.teal),
        );
      }

      return Column(children: itemCards);
    });
  }

  Widget _buildScheduleSection() {
    final ItemController controller = Get.find<ItemController>();

    return Obx(() {
      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPickupDeliveryCard(
                title: 'Pickup',
                date: controller.pickupDate.value,
                time: controller.pickupTime.value,
              ),
              Container(height: 60, width: 1, color: Colors.teal.shade100),
              _buildPickupDeliveryCard(
                title: 'Delivery',
                date: controller.deliveryDate.value,
                time: controller.deliveryTime.value,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPickupDeliveryCard({
    required String title,
    required String date,
    required String time,
  }) {
    return Column(
      children: [
        Icon(
          title == 'Pickup' ? Icons.delivery_dining : Icons.local_shipping,
          size: 40,
          color: Colors.teal,
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 4),
        Text(date, style: TextStyle(color: Colors.teal.shade700)),
        const SizedBox(height: 2),
        Text(time, style: TextStyle(color: Colors.teal.shade700)),
      ],
    );
  }

  Widget _buildBillDetailsSection() {
    final ItemController itemController = Get.find();

    return Obx(() {
      int subtotal = 0;
      for (int i = 0; i < itemController.items.length; i++) {
        final item = itemController.items[i];
        final qty = itemController.quantities[i].value;
        final price =
            int.tryParse(
              item['price'].toString().replaceAll(RegExp(r'[^\d]'), ''),
            ) ??
            0;

        subtotal += price * qty;
      }

      final double gst = subtotal * 0.18;
      final double deliveryCharge = 25.0;
      final double total = subtotal + gst + deliveryCharge;

      return Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bill Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              _buildBillRow('Subtotal', '₹$subtotal'),
              _buildBillRow('GST (18%)', '₹${gst.toStringAsFixed(2)}'),
              _buildBillRow(
                'Delivery Charge',
                '₹${deliveryCharge.toStringAsFixed(2)}',
              ),
              const Divider(color: Colors.teal),
              _buildBillRow(
                'Total',
                '₹${total.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBillRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
              color: Colors.teal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 16,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
