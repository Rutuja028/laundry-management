import 'package:get/get.dart';
import 'package:laundry_management/controllers/delivered_controller.dart';

class DeliveredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryController>(() => DeliveryController());
  }
}
