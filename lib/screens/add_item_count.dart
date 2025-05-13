import 'package:flutter/material.dart';
import 'package:laundry_management/screens/schedule_date_time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:laundry_management/screens/customer_detail_model.dart';

class AddItemCount extends StatefulWidget {
  const AddItemCount({super.key});

  @override
  State<AddItemCount> createState() => _AddItemCountState();
}

class _AddItemCountState extends State<AddItemCount> {
  TextEditingController demoController = TextEditingController();

  List<int> quantities = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/add_item/blazer.jpg',
      'name': 'Blazer',
      'price': 'r20/pc',
    },
    {
      'image': 'assets/add_item/tShirt.jpg',
      'name': 'T-shirt',
      'price': 'r40/pc',
    },
    {'image': 'assets/add_item/kurti.png', 'name': 'Kurta', 'price': 'r20/pc'},
    {
      'image': 'assets/add_item/blouse.png',
      'name': 'Blouse',
      'price': 'r30/pc',
    },
    {
      'image': 'assets/add_item/white_shirt.png',
      'name': 'Shirt',
      'price': 'r50/pc',
    },
    {
      'image': 'assets/add_item/trousers.jpg',
      'name': 'Trousers',
      'price': 'r50/pc',
    },
    {
      'image': 'assets/add_item/dupatta.png',
      'name': 'Dupatta',
      'price': 'r50/pc',
    },
    {
      'image': 'assets/add_item/sweater.jpg',
      'name': 'Sweater',
      'price': 'r50/pc',
    },
    {'image': 'assets/add_item/saree.jpg', 'name': 'Saree', 'price': 'r100/pc'},
  ];

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilterButton(title: 'All', isSelected: true),
                  FilterButton(title: 'TOPS'),
                  FilterButton(title: 'BOTTOMS'),
                  FilterButton(title: 'DRESS'),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // List of Items
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ItemCard(
                    image: items[index]['image'],
                    name: items[index]['name'],
                    price: items[index]['price'],
                    quantity: quantities[index],
                    onIncrement: () {
                      setState(() {
                        quantities[index]++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        if (quantities[index] > 0) quantities[index]--;
                      });
                    },
                  );
                },
              ),
            ),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScheduleDateTime(),
                    ),
                  );
                  // FirebaseFirestore.instance.collection("addItemList").add({
                  //   "quantities": quantities,
                  // });

                  /////Demo
                  List<String> quantities =
                      demoController.text.trim() as List<String>;
                  FirebaseFirestore.instance
                      .collection("addItemList")
                      .add(quantities as Map<String, dynamic>);
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
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
          ],
        ),
      ),
    );
  }
}

// Filter Button Widget
class FilterButton extends StatelessWidget {
  final String title;
  final bool isSelected;

  const FilterButton({super.key, required this.title, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
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
}

// Item Card Widget
class ItemCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.black54),
                    onPressed: onDecrement,
                  ),
                  Text(
                    '$quantity',
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
        ],
      ),
    );
  }
}
