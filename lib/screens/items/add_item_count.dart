import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/screens/items/schedule_date_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItemCount extends StatelessWidget {
  const AddItemCount({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6ABCF8), Colors.black87],
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Item', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF6ABCF8), Colors.black87],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // Filter Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(title: 'All', isSelected: true),
                  FilterButton(title: 'TOPS', isSelected: false),
                  FilterButton(title: 'BOTTOMS', isSelected: false),
                  FilterButton(title: 'DRESS', isSelected: false),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Item List
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return ItemCard(
                      image: item['image'],
                      name: item['name'],
                      price: item['price'],
                      quantity: controller.quantities[index], // pass RxInt
                      onIncrement: () => controller.incrementQuantity(index),
                      onDecrement: () => controller.decrementQuantity(index),
                    );
                  },
                );
              }),
            ),

            // Confirm Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
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

                    // await FirebaseFirestore.instance
                    //     .collection("addItemList")
                    //     .add({'items': selectedItems});

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ScheduleDateTime(selectedItems: selectedItems),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Filter Button Widget
  static Widget FilterButton({required String title, bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Item Card Widget
  static Widget ItemCard({
    required String image,
    required String name,
    required String price,
    required RxInt quantity,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ListTile(
              leading: Image.asset(
                image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(price, style: const TextStyle(color: Colors.grey)),
              trailing: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.black54),
                      onPressed: onDecrement,
                    ),
                    Text(
                      '${quantity.value}', // use reactive value
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.black54),
                      onPressed: onIncrement,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
