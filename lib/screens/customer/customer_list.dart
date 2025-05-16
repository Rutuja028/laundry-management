import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/customer_controller.dart';
import 'package:laundry_management/screens/items/select_services.dart';

class CustomerListScreen extends StatelessWidget {
  CustomerListScreen({super.key});

  final CustomerController customerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer List',
          style: TextStyle(color: Colors.teal), // OTP theme text color
        ),
        backgroundColor: const Color(0xFFE0F2F1), // OTP theme light teal
        iconTheme: const IconThemeData(color: Colors.teal),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE0F2F1), // OTP gradient start
              Color(0xFF80CBC4), // OTP gradient end
            ],
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
                      style: TextStyle(color: Colors.teal, fontSize: 16),
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
                              color: Colors.teal, // OTP theme accent
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                "Phone: ${customer['phone'] ?? 'N/A'}",
                                style: const TextStyle(color: Colors.black87),
                              ),
                              Text(
                                "Address: ${customer['address'] ?? 'N/A'}",
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ],
                          ),
                          onTap: () {
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
