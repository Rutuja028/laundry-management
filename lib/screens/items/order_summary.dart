import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Map<String, dynamic>? customerDetails;

  bool _showConfirmation = false;
  final OrderController orderController = Get.find<OrderController>();

  final CustomerController customerController = Get.find<CustomerController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.lightBlue.shade100,
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            title: const Text('Order Summary'),
          ),
          body: SingleChildScrollView(
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

          bottomSheet: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.black),
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
                    final customer = customerController.customerList.last;

                    int subtotal = 0;
                    final items = [];

                    for (int i = 0; i < itemController.items.length; i++) {
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
                      Get.toNamed('/home'); // Ensure this route exists
                    });
                  },

                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: const Text(
                    'Pay',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
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

  // Updated _buildAddressSection
  Widget _buildAddressSection() {
    return Obx(() {
      if (customerController.customerList.isEmpty) {
        return const Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("No customer details available."),
          ),
        );
      }

      final customer = customerController.customerList.last;

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.purple),
                  SizedBox(width: 8),
                  Text(
                    'Deliver to:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${customer['name']}\nPhone: ${customer['phone']}\nAddress: ${customer['address']}",
                style: const TextStyle(fontSize: 15),
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
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '₹${item['price']} x ${controller.quantities[i].value} = ₹${(int.tryParse(item['price'].toString().replaceAll(RegExp(r'[^\d]'), '')) ?? 0) * controller.quantities[i].value}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          );
        }
      }

      if (itemCards.isEmpty) {
        return const Text("No items selected.");
      }

      return Column(children: itemCards);
    });
  }

  Widget _buildScheduleSection() {
    final ItemController controller = Get.find<ItemController>();

    return Obx(() {
      return Card(
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
              Container(height: 60, width: 1, color: Colors.grey.shade300),
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
        ),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(date),
        Text(time),
      ],
    );
  }

  Widget _buildBillDetailsSection() {
    final ItemController controller = Get.find();

    return Obx(() {
      int subtotal = 0;

      for (int i = 0; i < controller.items.length; i++) {
        final priceStr = controller.items[i]['price'];
        final price =
            int.tryParse(
              priceStr.toString().replaceAll(RegExp(r'[^\d]'), ''),
            ) ??
            0;
        final quantity = controller.quantities[i].value;
        subtotal += price * quantity;
      }

      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bill Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Subtotal (for items): ₹$subtotal'),
              const Text('Service Charge: ₹0'),
              const Divider(),
              Text('Total: ₹$subtotal'),
            ],
          ),
        ),
      );
    });
  }
}
