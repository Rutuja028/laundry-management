import 'package:get/get.dart';

class ItemController extends GetxController {
  var selectedService = ''.obs;
  var selectedDetergent = 'Regular'.obs;
  var quantities = List<int>.generate(10, (index) => 0).obs;

  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/add_item/blazer.jpg',
      'name': 'Blazer',
      'price': '₹20/pc',
    },
    {
      'image': 'assets/add_item/tShirt.jpg',
      'name': 'T-shirt',
      'price': '₹40/pc',
    },
    {'image': 'assets/add_item/kurti.png', 'name': 'Kurta', 'price': '₹20/pc'},
    {
      'image': 'assets/add_item/blouse.png',
      'name': 'Blouse',
      'price': '₹30/pc',
    },
    {
      'image': 'assets/add_item/white_shirt.png',
      'name': 'Shirt',
      'price': '₹50/pc',
    },
    {
      'image': 'assets/add_item/trousers.jpg',
      'name': 'Trousers',
      'price': '₹50/pc',
    },
    {
      'image': 'assets/add_item/dupatta.png',
      'name': 'Dupatta',
      'price': '₹50/pc',
    },
    {
      'image': 'assets/add_item/sweater.jpg',
      'name': 'Sweater',
      'price': '₹50/pc',
    },
    {'image': 'assets/add_item/saree.jpg', 'name': 'Saree', 'price': '₹100/pc'},
  ];

  void incrementQuantity(int index) => quantities[index]++;
  void decrementQuantity(int index) {
    if (quantities[index] > 0) quantities[index]--;
  }

  void setService(String service) => selectedService.value = service;
  void setDetergent(String detergent) => selectedDetergent.value = detergent;
}
