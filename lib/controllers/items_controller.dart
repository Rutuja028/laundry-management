import 'package:get/get.dart';

class ItemController extends GetxController {
  var selectedService = ''.obs;
  var selectedDetergent = 'Regular'.obs;
  RxList<RxInt> quantities = <RxInt>[].obs;

  var pickupDate = ''.obs;
  var pickupTime = '8 AM - 10 AM'.obs;
  var deliveryDate = ''.obs;
  var deliveryTime = '8 AM - 10 AM'.obs;

  @override
  void onInit() {
    super.onInit();
    quantities.value = List.generate(items.length, (_) => 0.obs);
    final today = getFormattedDate(DateTime.now());
    if (pickupDate.value.isEmpty) pickupDate.value = today;
    if (deliveryDate.value.isEmpty) deliveryDate.value = today;
  }

  String getFormattedDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return "${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}";
  }

  var items =
      <Map<String, dynamic>>[
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
        {
          'image': 'assets/add_item/kurti.png',
          'name': 'Kurta',
          'price': '₹20/pc',
        },
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
        {
          'image': 'assets/add_item/saree.jpg',
          'name': 'Saree',
          'price': '₹100/pc',
        },
      ].obs;

  void incrementQuantity(int index) {
    quantities[index].value++;
  }

  void decrementQuantity(int index) {
    if (quantities[index].value > 0) {
      quantities[index].value--;
    }
  }

  void setService(String service) => selectedService.value = service;
  void setDetergent(String detergent) => selectedDetergent.value = detergent;

  void setPickupDate(String date) => pickupDate.value = date;
  void setDeliveryDate(String date) => deliveryDate.value = date;
  void setPickupTime(String time) => pickupTime.value = time;
  void setDeliveryTime(String time) => deliveryTime.value = time;
}
