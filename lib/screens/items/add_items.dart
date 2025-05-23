import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/routes/routes.dart';

class AddItemCount extends StatelessWidget {
  const AddItemCount({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController controller = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add Items',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFB2DFDB), Color(0xFF004D40)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      final item = controller.items[index];
                      return ItemCard(
                        image: item['image'],
                        name: item['name'],
                        price: item['price'],
                        quantity: controller.quantities[index],
                        onIncrement: () => controller.incrementQuantity(index),
                        onDecrement: () => controller.decrementQuantity(index),
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      final selectedItems = <Map<String, dynamic>>[];
                      for (int i = 0; i < controller.items.length; i++) {
                        if (controller.quantities[i] > 0) {
                          selectedItems.add({
                            'name': controller.items[i]['name'],
                            'price': controller.items[i]['price'],
                            'quantity': controller.quantities[i],
                          });
                        }
                      }
                      if (selectedItems.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Please select at least one item.",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      Get.toNamed(
                        Routes.scheduledatetime,
                        arguments: selectedItems,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.black45,
                      elevation: 8,
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget ItemCard({
    required String image,
    required String name,
    required String price,
    required RxInt quantity,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          price,
          style: const TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Obx(
          () => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.teal.shade50,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.teal,
                  ),
                  onPressed: onDecrement,
                ),
                Text(
                  '${quantity.value}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.teal,
                  ),
                  onPressed: onIncrement,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
