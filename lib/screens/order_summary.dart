// import 'package:flutter/material.dart';
// import 'package:laundry_app/screens/add_customer_details.dart';

// class OrderSummary extends StatefulWidget {
//   const OrderSummary({super.key});

//   @override
//   State createState() => _OrderSummaryState();
// }

// class _OrderSummaryState extends State<OrderSummary> {
//   AddCustomerDetail adCusDet = AddCustomerDetail();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue.shade100,
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue,
//         title: const Text('Order Summary'),
//         // leading: const Icon(Icons.arrow_back),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Delivery Address
//             const AddressSection(),

//             const SizedBox(height: 16),

//             // Items Section
//             const ItemsSection(),

//             const SizedBox(height: 16),

//             // Laundry Preferences
//             const PreferencesSection(),

//             const SizedBox(height: 16),

//             // Pickup and Delivery Info
//             const ScheduleSection(),

//             const SizedBox(height: 16),

//             // Bill Details
//             const BillDetailsSection(),

//             const SizedBox(height: 24),

//             // Proceed to Pay
//             Center(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.black,
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 onPressed: () {},
//                 child: const Text(
//                   'Proceed to Pay',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Address Section
// class AddressSection extends StatelessWidget {
//   const AddressSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Deliver to:',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//                 Text(
//                   'Change',
//                   style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.purple,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               "",
//               style: TextStyle(fontSize: 14, color: Colors.black87),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Items Section
// class ItemsSection extends StatelessWidget {
//   const ItemsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ItemCard(
//             itemName: 'Item Name 1', price: 50, imagePath: 'assets/item1.png'),
//         const SizedBox(height: 12),
//         ItemCard(
//             itemName: 'Item Name 2', price: 75, imagePath: 'assets/item2.png'),
//       ],
//     );
//   }
// }

// class ItemCard extends StatelessWidget {
//   final String itemName;
//   final int price;
//   final String imagePath;

//   const ItemCard(
//       {super.key,
//       required this.itemName,
//       required this.price,
//       required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: ListTile(
//         leading: Container(
//           width: 60,
//           height: 60,
//           color: Colors.grey.shade300, // Placeholder for image
//           child: Center(
//             child: Text(
//               'Img',
//               style: TextStyle(fontSize: 12),
//             ),
//           ),
//         ),
//         title: Text(
//           itemName,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         subtitle: Text('₹$price'),
//         trailing: QuantityCounter(),
//       ),
//     );
//   }
// }

// // Quantity Counter Widget
// class QuantityCounter extends StatefulWidget {
//   const QuantityCounter({super.key});

//   @override
//   _QuantityCounterState createState() => _QuantityCounterState();
// }

// class _QuantityCounterState extends State<QuantityCounter> {
//   int _count = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.remove_circle, color: Colors.blue),
//           onPressed: () {
//             setState(() {
//               if (_count > 0) _count--;
//             });
//           },
//         ),
//         Text('$_count', style: const TextStyle(fontSize: 16)),
//         IconButton(
//           icon: const Icon(Icons.add_circle, color: Colors.blue),
//           onPressed: () {
//             setState(() {
//               _count++;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }

// // Preferences Section
// class PreferencesSection extends StatelessWidget {
//   const PreferencesSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Laundry preference',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         TextButton(onPressed: () {}, child: const Text('Edit')),
//       ],
//     );
//   }
// }

// // Schedule Section
// class ScheduleSection extends StatelessWidget {
//   const ScheduleSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: const [
//           PickupDeliveryCard(
//               title: 'Pickup', date: 'Wed, 2 July', time: '10 AM - 12 PM'),
//           VerticalDivider(thickness: 1),
//           PickupDeliveryCard(
//               title: 'Delivery', date: 'Thu, 3 July', time: '10 AM - 12 PM'),
//         ],
//       ),
//     );
//   }
// }

// class PickupDeliveryCard extends StatelessWidget {
//   final String title, date, time;

//   const PickupDeliveryCard(
//       {super.key, required this.title, required this.date, required this.time});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(title == 'Pickup' ? Icons.delivery_dining : Icons.local_shipping,
//             size: 40),
//         Text(
//           title,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         Text(date),
//         Text(time),
//       ],
//     );
//   }
// }

// // Bill Details Section
// class BillDetailsSection extends StatelessWidget {
//   const BillDetailsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             Text('Bill Details',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Subtotal (for items): ₹125.00'),
//             Text('GST (18%): ₹22.50'),
//             Text('Delivery Fee: ₹40.00'),
//             Divider(),
//             Text('Total Amount: ₹187.50',
//                 style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderSummary extends StatefulWidget {
  const OrderSummary({super.key});

  @override
  State createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  Map<String, dynamic>? customerDetails;

  @override
  void initState() {
    super.initState();
    fetchCustomerDetails();
  }

  // Function to fetch the latest customer details from Firestore
  void fetchCustomerDetails() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection("customerDetails")
              .orderBy("timestamp", descending: true) // Fetch the latest entry
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          customerDetails = querySnapshot.docs.first.data();
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching details: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Order Summary'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address Section
            AddressSection(customerDetails: customerDetails),

            const SizedBox(height: 16),

            // Items Section
            const ItemsSection(),

            const SizedBox(height: 16),

            // Laundry Preferences
            const PreferencesSection(),

            const SizedBox(height: 16),

            // Pickup and Delivery Info
            const ScheduleSection(),

            const SizedBox(height: 16),

            // Bill Details
            const BillDetailsSection(),

            const SizedBox(height: 24),

            // Proceed to Pay Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Proceeding to Payment")),
                  );
                },
                child: const Text(
                  'Proceed to Pay',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Address Section
class AddressSection extends StatelessWidget {
  final Map<String, dynamic>? customerDetails;

  const AddressSection({super.key, required this.customerDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deliver to:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            customerDetails != null
                ? Text(
                  "${customerDetails!['name']}\nPhone: ${customerDetails!['phone']}\nAddress: ${customerDetails!['address']}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                )
                : const Text(
                  "Loading...",
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
          ],
        ),
      ),
    );
  }
}

// Items Section
class ItemsSection extends StatelessWidget {
  const ItemsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemCard(
          itemName: 'Item Name 1',
          price: 50,
          imagePath: 'assets/item1.png',
        ),
        const SizedBox(height: 12),
        ItemCard(
          itemName: 'Item Name 2',
          price: 75,
          imagePath: 'assets/item2.png',
        ),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final String itemName;
  final int price;
  final String imagePath;

  const ItemCard({
    super.key,
    required this.itemName,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          color: Colors.grey.shade300,
          child: Center(
            child: Text('Img', style: const TextStyle(fontSize: 12)),
          ),
        ),
        title: Text(
          itemName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text('₹$price'),
        trailing: const QuantityCounter(),
      ),
    );
  }
}

// Quantity Counter Widget
class QuantityCounter extends StatefulWidget {
  const QuantityCounter({super.key});

  @override
  _QuantityCounterState createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.blue),
          onPressed: () {
            setState(() {
              if (_count > 0) _count--;
            });
          },
        ),
        Text('$_count', style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add_circle, color: Colors.blue),
          onPressed: () {
            setState(() {
              _count++;
            });
          },
        ),
      ],
    );
  }
}

// Preferences Section
class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Laundry preference',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: () {}, child: const Text('Edit')),
      ],
    );
  }
}

// Schedule Section
class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          PickupDeliveryCard(
            title: 'Pickup',
            date: 'Wed, 2 July',
            time: '10 AM - 12 PM',
          ),
          VerticalDivider(thickness: 1),
          PickupDeliveryCard(
            title: 'Delivery',
            date: 'Thu, 3 July',
            time: '10 AM - 12 PM',
          ),
        ],
      ),
    );
  }
}

class PickupDeliveryCard extends StatelessWidget {
  final String title, date, time;

  const PickupDeliveryCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          title == 'Pickup' ? Icons.delivery_dining : Icons.local_shipping,
          size: 40,
        ),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(date),
        Text(time),
      ],
    );
  }
}

// Bill Details Section
class BillDetailsSection extends StatelessWidget {
  const BillDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Bill Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Subtotal (for items): ₹125.00'),
            Text('GST (18%): ₹22.50'),
            Text('Delivery Fee: ₹40.00'),
            Divider(),
            Text(
              'Total Amount: ₹187.50',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
