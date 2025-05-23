import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryController extends GetxController {
  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    ();
  }

  Future<void> fetchdeliveredOrders() async {
    try {
      isLoading.value = true;
      orders.clear();

      final customersSnapshot = await firestore.collection('customers').get();

      for (var customerDoc in customersSnapshot.docs) {
        final phone = customerDoc.id;

        final ordersSnapshot =
            await firestore
                .collection('customers')
                .doc(phone)
                .collection('orders')
                .where('status', isEqualTo: 'delivered')
                .get();

        for (var orderDoc in ordersSnapshot.docs) {
          final orderData = orderDoc.data();
          orderData['orderId'] = orderDoc.id;
          orderData['customer'] = customerDoc.data();
          orders.add(orderData);
        }
      }

      print('✅ Pending orders fetched successfully');
    } catch (e) {
      print('❌ Failed to fetch pending orders: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
