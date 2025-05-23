import 'package:get/get.dart';
import 'package:laundry_management/bindings/auth_binding.dart';
import 'package:laundry_management/bindings/customer_binding.dart';
import 'package:laundry_management/bindings/items_binding.dart';
import 'package:laundry_management/bindings/order_binding.dart';
import 'package:laundry_management/bindings/delivered_binding.dart';
import 'package:laundry_management/screens/auth/sign_in_page.dart';
import 'package:laundry_management/screens/customer/add_customer_info.dart';
import 'package:laundry_management/screens/customer/customer_list.dart';
import 'package:laundry_management/screens/home/home_page.dart';
import 'package:laundry_management/screens/items/add_items.dart';
import 'package:laundry_management/screens/items/order_summary.dart';
import 'package:laundry_management/screens/items/schedule_date_time.dart';
import 'package:laundry_management/screens/items/select_services.dart';
import 'package:laundry_management/screens/orders/orders_screen.dart';
import 'package:laundry_management/screens/auth/otp_page.dart';
import 'package:laundry_management/screens/delivered/delivered.dart';
import 'package:laundry_management/routes/routes.dart';

class AppPages {
  AppPages._();

  static const Transition transition = Transition.native;
  static const String initialRoute = Routes.signinpage;

  static final route = [
    GetPage(
      name: Routes.signinpage,
      page: () => SignInPage(),
      binding: AuthBinding(),
      transition: transition,
    ),

    GetPage(name: Routes.home, page: () => HomePage(), transition: transition),

    GetPage(
      name: Routes.orders,
      page: () => OrderScreen(),
      bindings: [OrderBinding(), CustomerBinding(), DeliveredBinding()],
      transition: transition,
    ),

    GetPage(name: Routes.otp, page: () => OTPPage(), transition: transition),

    GetPage(
      name: Routes.delivered,
      page: () => DeliveredOrdersScreen(),
      binding: DeliveredBinding(),
      transition: transition,
    ),

    GetPage(
      name: Routes.customerlist,
      page: () => CustomerListScreen(),
      binding: CustomerBinding(),
      transition: transition,
    ),

    GetPage(
      name: Routes.selectServices,
      page: () => SelectServices(),
      binding: ItemsBinding(),
      transition: transition,
    ),

    GetPage(
      name: Routes.addCustomer,
      page: () => AddCustomerDetail(),
      binding: CustomerBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.additem,
      page: () => AddItemCount(),
      binding: ItemsBinding(),
      transition: transition,
    ),
    GetPage(
      name: Routes.scheduledatetime,
      page: () => ScheduleDateTime(),
      binding: ItemsBinding(),
      transition: transition,
    ),

    GetPage(
      name: Routes.ordersummary,
      page: () => OrderSummary(),
      binding: OrderBinding(),
      transition: transition,
    ),
  ];
}
