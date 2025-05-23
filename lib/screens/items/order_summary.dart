import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/customer_controller.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/controllers/order_controller.dart';
import 'package:laundry_management/routes/routes.dart';

class OrderSummary extends StatelessWidget {
  final List<Map<String, dynamic>>? selectedItems;

  OrderSummary({Key? key, this.selectedItems}) : super(key: key);

  final OrderController orderController = Get.find<OrderController>();
  final CustomerController customerController = Get.find<CustomerController>();

  final RxBool _showConfirmation = false.obs;

  @override
  Widget build(BuildContext context) {
    final ItemController itemController = Get.find<ItemController>();

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.teal.shade50,
            body: SafeArea(
              child: Column(
                children: [
                  // AppBar
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade300, Colors.teal.shade600],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade900.withOpacity(0.3),
                          offset: const Offset(0, 3),
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Order Summary',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.teal.shade50,
                          letterSpacing: 1.1,
                          shadows: const [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black26,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
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
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  // Buttons Row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(
                                color: Colors.teal.shade700,
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              'Back',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showConfirmation.value = true;

                              final customer =
                                  customerController.customerList.last;
                              int subtotal = 0;
                              final items = <Map<String, dynamic>>[];

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
                                _showConfirmation.value = false;
                                Get.toNamed(Routes.home);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Pay',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Confirmation overlay
          if (_showConfirmation.value)
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                color: Colors.black.withOpacity(0.75),
                child: Center(
                  child: AnimatedScale(
                    scale: _showConfirmation.value ? 1 : 0.8,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutBack,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 36,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade800,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade900.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 90,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Payment Confirmed!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Obx(() {
      if (customerController.customerList.isEmpty) {
        return _simpleCard("No customer details available.");
      }
      final customer = customerController.customerList.last;
      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.teal.shade700),
                  const SizedBox(width: 8),
                  Text(
                    'Deliver to:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "${customer['name']}\nPhone: ${customer['phone']}\nAddress: ${customer['address']}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal.shade900,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildItemsSection() {
    final ItemController controller = Get.find<ItemController>();
    final items = selectedItems ?? [];
    if (items.isNotEmpty) {
      return _itemsList(items);
    }
    return Obx(() {
      final activeItems = <Map<String, dynamic>>[];
      for (int i = 0; i < controller.items.length; i++) {
        if (controller.quantities[i].value > 0)
          activeItems.add({
            ...controller.items[i],
            'quantity': controller.quantities[i].value,
          });
      }
      return _itemsList(activeItems);
    });
  }

  Widget _itemsList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.teal.shade800,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) {
          final qty =
              item['quantity'] is RxInt
                  ? item['quantity'].value
                  : item['quantity'];
          final priceInt =
              int.tryParse(
                item['price'].toString().replaceAll(RegExp(r'[^\d]'), ''),
              ) ??
              0;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 3,
            color: Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              leading:
                  item['image'] != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                      : null,
              title: Text(
                item['name'],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.teal.shade800,
                ),
              ),
              subtitle: Text(
                '₹${item['price']} x $qty = ₹${priceInt * qty}',
                style: TextStyle(color: Colors.teal.shade600, fontSize: 14),
              ),
              trailing: const Icon(
                Icons.check_circle_outline,
                color: Colors.teal,
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildScheduleSection() {
    final ItemController controller = Get.find<ItemController>();

    return Obx(() {
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
          size: 36,
          color: Colors.teal.shade700,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.teal.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(date, style: TextStyle(color: Colors.teal.shade600, fontSize: 13)),
        const SizedBox(height: 2),
        Text(time, style: TextStyle(color: Colors.teal.shade600, fontSize: 13)),
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
      const double deliveryCharge = 25.0;
      final double total = subtotal + gst + deliveryCharge;

      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bill Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.teal.shade800,
                ),
              ),
              const SizedBox(height: 12),
              _buildBillRow('Subtotal', '₹$subtotal'),
              _buildBillRow('GST (18%)', '₹${gst.toStringAsFixed(2)}'),
              _buildBillRow(
                'Delivery Charge',
                '₹${deliveryCharge.toStringAsFixed(2)}',
              ),
              Divider(color: Colors.teal.shade200, thickness: 1, height: 20),
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

  Widget _buildBillRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
              color: Colors.teal.shade700,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
              color: Colors.teal.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _simpleCard(String message) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Text(
          message,
          style: TextStyle(color: Colors.teal.shade600, fontSize: 14),
        ),
      ),
    );
  }
}
