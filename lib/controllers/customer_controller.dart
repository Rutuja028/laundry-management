import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerController extends GetxController {
  // Use dynamic instead of String for compatibility with Firestore
  RxList<Map<String, dynamic>> customerList = <Map<String, dynamic>>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCustomersFromFirestore();
  }

  void fetchCustomersFromFirestore() async {
    try {
      final snapshot = await firestore.collection('customers').get();
      customerList.clear();
      for (var doc in snapshot.docs) {
        customerList.add(doc.data()); // doc.data() is Map<String, dynamic>
      }
      print('✅ Customers fetched successfully');
      print(snapshot);
    } catch (e) {
      print('❌ Failed to fetch customers: $e');
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
