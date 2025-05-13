import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/customer_controller.dart';
import 'package:laundry_management/screens/items/select_services.dart'; // Make sure to import SelectServices

class CustomerListScreen extends StatelessWidget {
  CustomerListScreen({super.key});

  final CustomerController customerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer List'),
        backgroundColor: const Color.fromARGB(255, 22, 192, 223),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 22, 192, 223), Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(
          () =>
              customerController.customerList.isEmpty
                  ? const Center(
                    child: Text(
                      'No customers added yet.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                  : ListView.builder(
                    itemCount: customerController.customerList.length,
                    itemBuilder: (context, index) {
                      final customer = customerController.customerList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.white,
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          title: Text(
                            customer['name'] ?? 'Unknown',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text("Phone: ${customer['phone'] ?? 'N/A'}"),
                              Text("Address: ${customer['address'] ?? 'N/A'}"),
                            ],
                          ),
                          onTap: () {
                            // Navigate to SelectServices when customer is clicked
                            Get.to(const SelectServices());
                          },
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
