import 'package:flutter/material.dart';
import 'package:laundry_management/screens/select_services.dart';

class AddCustomerDetail extends StatefulWidget {
  const AddCustomerDetail({super.key});

  @override
  State createState() => _AddCustomerDetailState();
}

class _AddCustomerDetailState extends State<AddCustomerDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  bool isLoading = false;

  void saveCustomerDetails() async {
    if (nameController.text.trim().isNotEmpty &&
        phoneController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        isLoading = false;
      });

      nameController.clear();
      phoneController.clear();
      addressController.clear();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SelectServices()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 22, 192, 223), Colors.black87],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                "Customer \nDetails",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text("Name"),
                    TextFormField(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      decoration: const InputDecoration(
                        hintText: "Enter your name",
                        prefixIcon: Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 9, 162, 189),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Phone"),
                    TextFormField(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      decoration: const InputDecoration(
                        hintText: "Enter your phone no",
                        prefixIcon: Icon(Icons.phone),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 9, 162, 189),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Address"),
                    TextFormField(
                      controller: addressController,
                      focusNode: addressFocusNode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.home),
                        hintText: "Enter your address",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 9, 162, 189),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child:
                          isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: saveCustomerDetails,
                                child: const Text(
                                  "Next",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
