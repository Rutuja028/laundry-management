import 'package:get/get.dart';
import 'package:laundry_management/controllers/customer_controller.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(() => CustomerController());
  }
}
