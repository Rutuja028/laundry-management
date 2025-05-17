import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerController extends GetxController {
  RxList<Map<String, dynamic>> customerList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCustomersFromFirestore();
  }

  void fetchCustomersFromFirestore() async {
    try {
      isLoading.value = true;
      final snapshot = await firestore.collection('customers').get();
      customerList.clear();
      for (var doc in snapshot.docs) {
        customerList.add(doc.data());
      }
      print('✅ Customers fetched successfully');
      print(snapshot);
    } catch (e) {
      print('❌ Failed to fetch customers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCustomer(String name, String phone, String address) async {
    final newCustomer = {'name': name, 'phone': phone, 'address': address};

    try {
      await firestore.collection('customers').doc(phone).set(newCustomer);
      customerList.add(newCustomer);
    } catch (e) {
      print('❌ Failed to add customer: $e');
    }
  }
}
