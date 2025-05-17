import 'package:get/get.dart';
import 'package:laundry_management/controllers/items_controller.dart';

class ItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(() => ItemController());
  }
}
