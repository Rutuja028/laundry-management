import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderController extends GetxController {
  RxList<Map<String, dynamic>> orders = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  final GetStorage storage = GetStorage();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchAllOrders();
    ();
  }

  Future<void> addOrder(Map<String, dynamic> order) async {
    final customer = order['customer'];
    final phone = customer['phone'];

    try {
      await firestore
          .collection('customers')
          .doc(phone)
          .collection('orders')
          .add(order);
      orders.add(order); // <-- keep local list updated
      print('✅ Order saved to Firestore');
    } catch (e) {
      print('❌ Failed to add order: $e');
    }
  }

  Future<void> fetchAllOrders() async {
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
                .get();

        for (var orderDoc in ordersSnapshot.docs) {
          final orderData = orderDoc.data();
          orderData['orderId'] = orderDoc.id; // <--- ADD THIS
          orderData['customer'] = customerDoc.data();
          orders.add(orderData);
        }

        orders.sort((a, b) {
          final aStatus = a['status'] ?? 'pending';
          final bStatus = b['status'] ?? 'pending';

          if (aStatus == 'delivered' && bStatus != 'delivered') return 1;
          if (aStatus != 'delivered' && bStatus == 'delivered') return -1;
          return 0;
        });
      }

      print('✅ All orders fetched successfully');
    } catch (e) {
      print('❌ Failed to fetch orders: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrderStatus({
    required String customerPhone,
    required String orderId,
    required String status,
  }) async {
    try {
      await firestore
          .collection('customers')
          .doc(customerPhone)
          .collection('orders')
          .doc(orderId)
          .update({'status': status});

      // Also update locally in the orders list if present
      final index = orders.indexWhere(
        (order) =>
            order['orderId'] == orderId &&
            order['customer']['phone'] == customerPhone,
      );
      if (index != -1) {
        orders[index]['status'] = status;
        orders.refresh();
      }

      orders.sort((a, b) {
        final aStatus = a['status'] ?? 'pending';
        final bStatus = b['status'] ?? 'pending';

        if (aStatus == 'delivered' && bStatus != 'delivered') return 1;
        if (aStatus != 'delivered' && bStatus == 'delivered') return -1;
        return 0;
      });
      orders.refresh();

      print('✅ Order status updated to $status');
    } catch (e) {
      print('❌ Failed to update order status: $e');
    }
  }

  Future<void> fetchdeliveredOrders() async {
    try {
      orders.clear();

      final customersSnapshot = await firestore.collection('customers').get();

      for (var customerDoc in customersSnapshot.docs) {
        final phone = customerDoc.id;

        final ordersSnapshot =
            await firestore
                .collection('customers')
                .doc(phone)
                .collection('orders')
                .where(
                  'status',
                  isEqualTo: 'delivered',
                ) // filter in Firestore query
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
    }
  }
}
