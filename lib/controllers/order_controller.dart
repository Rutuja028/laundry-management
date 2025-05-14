// import 'package:get/get.dart';

// class OrderController extends GetxController {
//   RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;

//   void addOrder(Map<String, dynamic> order) {
//     orders.add(order);
//   }
// }

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OrderController extends GetxController {
  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadOrdersFromStorage(); // Load stored orders when the controller is initialized
  }

  // Load orders from storage
  void _loadOrdersFromStorage() {
    final storedOrders = storage.read<List>('orders');
    if (storedOrders != null) {
      orders.addAll(List<Map<String, dynamic>>.from(storedOrders));
    }
  }

  // Add order and store it in storage
  void addOrder(Map<String, dynamic> order) {
    orders.add(order);
    _saveOrdersToStorage(); // Save the updated orders to storage
  }

  // Save orders to storage
  void _saveOrdersToStorage() {
    storage.write('orders', orders);
  }
}
