import 'package:flutter/material.dart';
import 'package:laundry_management/screens/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool _showPass = false;
  bool _confirmPass = false;

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
                "Hello, \nSign Up!",
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
                    const Text("Email"),
                    TextFormField(
                      controller: emailController,
                      focusNode: emailFocusNode,
                      decoration: const InputDecoration(
                        hintText: "Enter your mail id",
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
                    const Text("Password"),
                    TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: _showPass,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPass ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPass = !_showPass;
                            });
                          },
                        ),
                        hintText: "Enter your password",
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 9, 162, 189),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 20),
                    const Text("Confirm Password"),
                    TextFormField(
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                      obscureText: _confirmPass,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _confirmPass = !_confirmPass;
                            });
                          },
                        ),
                        hintText: "Confirm your password",
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 9, 162, 189),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Spacer(),
                    Center(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 22, 192, 223),
                              Colors.black87,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color.fromARGB(255, 16, 153, 177),
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
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
