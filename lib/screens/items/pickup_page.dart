import 'package:flutter/material.dart';
import 'package:laundry_management/screens/items/order_summary.dart';
import 'package:laundry_management/style_scheme.dart';

class PickUpTimePage extends StatefulWidget {
  const PickUpTimePage({required Key key}) : super(key: key);

  @override
  _PickUpTimePageState createState() => _PickUpTimePageState();
}

class _PickUpTimePageState extends State<PickUpTimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          "Select Date & Time",
          style: TextStyle(color: Colors.black),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Text("Pick up Date", style: headingStyle),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  dateWidget("Wed", "07 Aug", true),
                  dateWidget("Thu", "08 Aug", false),
                  dateWidget("Fri", "09 Aug", false),
                  dateWidget("Sat", "10 Aug", false),
                  dateWidget("Mon", "12 Aug", false),
                  dateWidget("Tue", "13 Aug", false),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(height: 1, color: Colors.grey),
            SizedBox(height: 15),
            Text("Pick up Time", style: headingStyle),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  timeWidget("10:00 AM to 12:00 PM", false),
                  timeWidget("12:00 PM to 02:00 PM", true),
                  timeWidget("02:00 PM to 04:00 PM", false),
                  timeWidget("04:00 PM to 06:00 PM", false),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Delivery Date", style: headingStyle),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  dateWidget("Wed", "10 Aug", true),
                  dateWidget("Thu", "11 Aug", false),
                  dateWidget("Fri", "12 Aug", false),
                  dateWidget("Sat", "13 Aug", false),
                  dateWidget("Mon", "14 Aug", false),
                  dateWidget("Tue", "15 Aug", false),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(height: 1, color: Colors.grey),
            SizedBox(height: 15),
            Text("Delivery Time", style: headingStyle),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  timeWidget("10:00 AM to 12:00 PM", false),
                  timeWidget("12:00 PM to 02:00 PM", true),
                  timeWidget("02:00 PM to 04:00 PM", false),
                  timeWidget("04:00 PM to 06:00 PM", false),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount Payable", style: headingStyle),
                Text("\$225", style: headingStyle),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderSummary()),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(gradient: gradientStyle),
                child: Center(
                  child: Text(
                    "PLACE ORDER",
                    style: contentStyle.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container dateWidget(String day, String date, bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (isActive) ? Colors.orange : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: contentStyle.copyWith(
              color: (isActive) ? Colors.white : Colors.black,
              fontSize: 23,
            ),
          ),
          Text(
            date,
            style: contentStyle.copyWith(
              color: (isActive) ? Colors.white : Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Container timeWidget(String time, bool isActive) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: (isActive) ? Colors.orange : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: contentStyle.copyWith(
              color: (isActive) ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
