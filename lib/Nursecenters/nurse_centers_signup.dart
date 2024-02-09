import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Nursecenters/centers_home.dart';
import 'package:test/Nursecenters/nurse_centers_login.dart';
import 'package:test/utils/firebase_auth.dart';

class CentersSignUp extends StatefulWidget {
  const CentersSignUp({super.key});

  @override
  State<CentersSignUp> createState() => _CentersSignUpState();
}

class _CentersSignUpState extends State<CentersSignUp> {
  bool showHidePassword = true;
  final formKey = GlobalKey<FormState>();
  final adminNameController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: const Color(0xFFE8ECF4),
      body: SingleChildScrollView(
        child: SafeArea(
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
                                builder: (context) => CentersLogin(),
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
                                "Hello! Register to get  \nstarted",
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
                                controller: adminNameController,
                                cursorColor: Color(0xFF1C8892),
                                decoration: InputDecoration(
                                  labelText: "Admin",
                                  labelStyle:
                                      TextStyle(color: Color(0xFF1C8892)),
                                  hintText: "Enter your Name",
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
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$')
                                          .hasMatch(value)) {
                                    return "Please enter your name correctly ";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                  controller: adminEmailController,
                                  cursorColor: Color(0xFF1C8892),
                                  decoration: InputDecoration(
                                    labelStyle:
                                        TextStyle(color: Color(0xFF1C8892)),
                                    labelText: "Email",
                                    hintText: "Enter your Email",
                                    contentPadding: EdgeInsets.all(18),
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
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
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                cursorColor: Color(0xFF1C8892),
                                obscureText: showHidePassword,
                                controller: adminPasswordController,
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
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                                validator: (value) {
                                  RegExp regex = RegExp(
                                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                  var passNonNullValue = value ?? "";
                                  if (passNonNullValue.isEmpty) {
                                    return ("Password is required");
                                  } else if (passNonNullValue.length < 9) {
                                    return ("Password Must be more than 8 characters");
                                  } else if (!regex
                                      .hasMatch(passNonNullValue)) {
                                    return ("Password should contain upper,lower,digit and Special character ");
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                cursorColor: Color(0xFF1C8892),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Color(0xFF1C8892),
                                  ),
                                  labelText: "Confirm password",
                                  hintText: "Confirm your password",
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
                                    return "Confirm Password is required";
                                  } else if (value !=
                                      adminPasswordController.text) {
                                    return 'The password does not match';
                                  }
                                  return null;
                                },
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
                                          if (formKey.currentState!
                                              .validate()) {
                                            try {
                                              // Create the user account in Firebase Authentication
                                              var x = await MyFirebaseAuth()
                                                  .createAccount(
                                                email:
                                                    adminEmailController.text,
                                                password:
                                                    adminPasswordController
                                                        .text,
                                                context: context,
                                              );

                                              // If account creation is successful
                                              if (x != null) {
                                                // Show a success message
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
                                                        fontFamily: GoogleFonts
                                                                .poppins()
                                                            .fontFamily,
                                                      ),
                                                    ),
                                                  ),
                                                );

                                                // Add user data to Firestore
                                                CollectionReference centers =
                                                    FirebaseFirestore.instance
                                                        .collection('centers');
                                                await centers.add({
                                                  'Admin':
                                                      adminNameController.text,
                                                  'Email':
                                                      adminEmailController.text,
                                                });

                                                // Navigate to the home screen
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CentersHome(),
                                                  ),
                                                );
                                              }
                                            } catch (e) {
                                              // Handle errors, such as displaying an error message
                                              print("Error: $e");
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  backgroundColor: Colors.red,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                    "Failed to create account: $e",
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontFamily:
                                                          GoogleFonts.poppins()
                                                              .fontFamily,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        )),
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
                        "Already have account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Color(0xFF1C8892),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
