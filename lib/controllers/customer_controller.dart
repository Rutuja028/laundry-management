import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerController extends GetxController {
  // List to hold customer details
  RxList<Map<String, String>> customerList = <Map<String, String>>[].obs;

  // Instance of GetStorage
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadCustomers();
  }

  // Load customers from local storage
  void _loadCustomers() {
    final storedCustomers = storage.read<List>('customers');
    if (storedCustomers != null) {
      // Cast each item to Map<String, String>
      customerList.addAll(
        List<Map<String, String>>.from(
          storedCustomers.map((item) => Map<String, String>.from(item)),
        ),
      );
    }
  }

  // Add a new customer to the list and store it in local storage
  void addCustomer(String name, String phone, String address) {
    final newCustomer = {'name': name, 'phone': phone, 'address': address};
    customerList.add(newCustomer);
    storage.write('customers', customerList);
  }
}
