import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry_management/controllers/items_controller.dart';
import 'package:laundry_management/routes/routes.dart';

class SelectServices extends StatelessWidget {
  const SelectServices({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemController controller = Get.find();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Services',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Your Service',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: _serviceOptions(controller),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose Detergent',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _detergentOptions(controller),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Text(
                    'Proceed with ${controller.selectedService.value} & ${controller.selectedDetergent.value} detergent?',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              if (controller.selectedService.value.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select a service')),
                );
                return;
              }
              Get.toNamed(Routes.additem);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent.shade700,
              foregroundColor: Colors.white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text(
              'Proceed',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _serviceOptions(ItemController controller) => [
    _serviceCard('Wash', '₹20', 'assets/services/wash.jpg', controller),
    _serviceCard(
      'Wash & Fold',
      '₹40',
      'assets/services/washAndFold.jpg',
      controller,
    ),
    _serviceCard('Iron', '₹20', 'assets/services/iron.jpg', controller),
    _serviceCard(
      'Dry Clean',
      '₹30',
      'assets/services/dryClean.jpg',
      controller,
    ),
  ];

  Widget _serviceCard(
    String title,
    String price,
    String image,
    ItemController controller,
  ) {
    final bool selected = controller.selectedService.value == title;

    return GestureDetector(
      onTap: () => controller.setService(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: selected ? Colors.tealAccent.shade700 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 4),
                blurRadius: 10,
              ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 60),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.teal.shade900,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                color: selected ? Colors.white70 : Colors.teal.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _detergentOptions(ItemController controller) => [
    _detergentCard('Regular', controller),
    _detergentCard('Perfume Free', controller),
    _detergentCard('Eco-friendly', controller),
  ];

  Widget _detergentCard(String title, ItemController controller) {
    final bool selected = controller.selectedDetergent.value == title;

    return GestureDetector(
      onTap: () => controller.setDetergent(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.teal.shade800,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white54),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.teal.shade900 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
