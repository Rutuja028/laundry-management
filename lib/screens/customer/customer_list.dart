import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/customer_controller.dart';
import 'package:laundry_management/screens/items/select_services.dart';
import 'package:shimmer/shimmer.dart';

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
        child: Obx(() {
          if (customerController.isLoading.value) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.white,
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          title: Container(
                            width: 100,
                            height: 18,
                            color: Colors.grey[300],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Container(
                                width: 80,
                                height: 14,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 120,
                                height: 14,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              ),
            );
          }
          if (customerController.customerList.isEmpty) {
            return const Center(
              child: Text(
                'No customers added yet.',
                style: TextStyle(color: Colors.teal, fontSize: 16),
              ),
            );
          }
          return ListView.builder(
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
                        "Phone: " + (customer['phone'] ?? 'N/A'),
                        style: const TextStyle(color: Colors.black87),
                      ),
                      Text(
                        "Address: " + (customer['address'] ?? 'N/A'),
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
          );
        }),
      ),
    );
  }
}
