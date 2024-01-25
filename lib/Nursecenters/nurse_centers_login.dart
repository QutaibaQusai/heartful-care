import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Nursecenters/centers_home.dart';
import 'package:test/Nursecenters/nurse_centers_signup.dart';
import 'package:test/screens/login_screen.dart';
import 'package:test/utils/firebase_auth.dart';

class CentersLogin extends StatefulWidget {
  const CentersLogin({super.key});

  @override
  State<CentersLogin> createState() => _CentersLoginState();
}

class _CentersLoginState extends State<CentersLogin> {
  final formKey = GlobalKey<FormState>();

  TextEditingController centerEmailController = TextEditingController();
  TextEditingController centerPasswordController = TextEditingController();
  bool showHidePassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xFFE8ECF4),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogInScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.back,
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome back! Glad \nto see you again!",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1C8892),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                cursorColor: Color(0xFF1C8892),
                                controller: centerEmailController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Color(0xFF1C8892),
                                  ),
                                  labelText: "Email",
                                  hintText: "Enter your Email",
                                  contentPadding: EdgeInsets.all(18),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your email address";
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                cursorColor: Color(0xFF1C8892),
                                obscureText: showHidePassword,
                                controller: centerPasswordController,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Color(0xFF1C8892),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: IconButton(
                                      color: Color(0xFF1C8892),
                                      onPressed: () {
                                        setState(() {});
                                        showHidePassword = !showHidePassword;
                                      },
                                      icon: Icon(showHidePassword
                                          ? Icons.remove_red_eye
                                          : Icons.visibility_off),
                                    ),
                                  ),
                                  labelText: "Password",
                                  hintText: "Enter your password",
                                  contentPadding: EdgeInsets.all(18),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ("Password is required");
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      // Handle forgot password logic
                                    },
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF1C8892)),
                                        side: MaterialStateProperty.all(
                                            BorderSide(
                                                color: Color(0xFF1C8892))),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        fixedSize:
                                            MaterialStateProperty.all<Size>(
                                                const Size.fromWidth(370)),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                          EdgeInsets.symmetric(vertical: 20),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          final x = await MyFirebaseAuth()
                                              .signIn(
                                                  context: context,
                                                  email: centerEmailController
                                                      .text,
                                                  password:
                                                      centerPasswordController
                                                          .text);
                                          if (x != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Color(0xFF1C8892),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                      "Logged In Successfully",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily),
                                                    ),
                                                  ),
                                                )
                                                .closed
                                                .whenComplete(() =>
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CentersHome(),
                                                      ),
                                                    ));
                                          }
                                        }
                                      },
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // New Row for "Don’t have an account?" and "Register now"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CentersSignUp()));
                        },
                        child: Text(
                          "Register now",
                          style: TextStyle(
                            color: Color(0xFF1C8892),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),
                  /*TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CentersHome(),
                        ),
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
