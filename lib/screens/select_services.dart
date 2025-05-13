import 'package:flutter/material.dart';
import 'package:laundry_management/screens/add_item_count.dart';

class SelectServices extends StatefulWidget {
  const SelectServices({super.key});

  @override
  State<SelectServices> createState() => _SelectServicesState();
}

class _SelectServicesState extends State<SelectServices> {
  String selectedService = '';
  String selectedDetergent = 'Regular';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Item', style: TextStyle(color: Colors.black)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF6ABCF8), Colors.black87],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Select Services
              const Text(
                'Select Services',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ServiceCard(
                    imagePath: 'assets/services/wash.jpg',
                    title: 'Wash',
                    price: '₹20',
                    isSelected: selectedService == 'Wash',
                    onTap: () {
                      setState(() {
                        selectedService = 'Wash';
                      });
                    },
                  ),
                  ServiceCard(
                    imagePath: 'assets/services/washAndFold.jpg',
                    title: 'Wash & Fold',
                    price: '₹40',
                    isSelected: selectedService == 'Wash & Fold',
                    onTap: () {
                      setState(() {
                        selectedService = 'Wash & Fold';
                      });
                    },
                  ),
                  ServiceCard(
                    imagePath: 'assets/services/iron.jpg',
                    title: 'Iron',
                    price: '₹20',
                    isSelected: selectedService == 'Iron',
                    onTap: () {
                      setState(() {
                        selectedService = 'Iron';
                      });
                    },
                  ),
                  ServiceCard(
                    imagePath: 'assets/services/dryClean.jpg',
                    title: 'Dry Clean',
                    price: '₹30',
                    isSelected: selectedService == 'Dry Clean',
                    onTap: () {
                      setState(() {
                        selectedService = 'Dry Clean';
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Select Detergent
              const Text(
                'Select Detergent',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetergentOption(
                    title: 'Regular',
                    isSelected: selectedDetergent == 'Regular',
                    onTap: () {
                      setState(() {
                        selectedDetergent = 'Regular';
                      });
                    },
                  ),
                  DetergentOption(
                    title: 'Perfume Free',
                    isSelected: selectedDetergent == 'Perfume Free',
                    onTap: () {
                      setState(() {
                        selectedDetergent = 'Perfume Free';
                      });
                    },
                  ),
                  DetergentOption(
                    title: 'Eco-friendly',
                    isSelected: selectedDetergent == 'Eco-friendly',
                    onTap: () {
                      setState(() {
                        selectedDetergent = 'Eco-friendly';
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Proceed Text
              Text(
                'Do you want to proceed with $selectedService and $selectedDetergent detergent?',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle proceed logic here
                  if (selectedService.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a service!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Proceeding with $selectedService and $selectedDetergent detergent.',
                        ),
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddItemCount(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: const Text(
                  'Proceed',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Service Card Widget
class ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
          ],
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
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Text(
              price,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white70 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Detergent Option Widget
class DetergentOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const DetergentOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
