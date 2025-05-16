import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/screens/items/add_item_count.dart';

class SelectServices extends StatelessWidget {
  const SelectServices({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController itemController = Get.find<ItemController>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0F2F1), Color(0xFF80CBC4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Item',
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F2F1), Color(0xFF80CBC4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSectionTitle('Select Services'),
                const SizedBox(height: 10),
                Obx(() => _buildServiceGrid(itemController)),
                const SizedBox(height: 20),
                _buildSectionTitle('Select Detergent'),
                const SizedBox(height: 10),
                Obx(() => _buildDetergentOptions(itemController)),
                const SizedBox(height: 20),
                Obx(
                  () => Text(
                    'Do you want to proceed with ${itemController.selectedService.value} and ${itemController.selectedDetergent.value} detergent?',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildProceedButton(context, itemController),
    );
  }

  Widget _buildSearchBar() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: const TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search, color: Colors.teal),
        border: InputBorder.none,
      ),
    ),
  );

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.teal,
    ),
  );

  Widget _buildServiceGrid(ItemController controller) => GridView.count(
    shrinkWrap: true,
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
    childAspectRatio: 0.9,
    physics: const NeverScrollableScrollPhysics(),
    children: [
      _buildServiceCard('Wash', '₹20', 'assets/services/wash.jpg', controller),
      _buildServiceCard(
        'Wash & Fold',
        '₹40',
        'assets/services/washAndFold.jpg',
        controller,
      ),
      _buildServiceCard('Iron', '₹20', 'assets/services/iron.jpg', controller),
      _buildServiceCard(
        'Dry Clean',
        '₹30',
        'assets/services/dryClean.jpg',
        controller,
      ),
    ],
  );

  Widget _buildServiceCard(
    String title,
    String price,
    String imagePath,
    ItemController controller,
  ) {
    final bool isSelected = controller.selectedService.value == title;

    return GestureDetector(
      onTap: () => controller.setService(title),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
          ],
          border: Border.all(
            color: isSelected ? Colors.teal : Colors.black12,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.teal.shade900,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.teal.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetergentOptions(ItemController controller) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildDetergentOption('Regular', controller),
      _buildDetergentOption('Perfume Free', controller),
      _buildDetergentOption('Eco-friendly', controller),
    ],
  );

  Widget _buildDetergentOption(String title, ItemController controller) {
    final bool isSelected = controller.selectedDetergent.value == title;

    return GestureDetector(
      onTap: () => controller.setDetergent(title),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal.shade200),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.teal.shade900,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildProceedButton(BuildContext context, ItemController controller) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (controller.selectedService.value.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a service!')),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddItemCount()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
            child: const Text(
              'Proceed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
