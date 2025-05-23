import 'package:get/get.dart';
import 'package:laundry_management/controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
    // Get.lazyPut<OrderController>(() => OrderController());
  }
}
