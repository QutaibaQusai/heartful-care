import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Authentication%20firebase/firebase_auth.dart';
import 'package:test/Nursecenters/centers_home.dart';
import 'package:test/Nursecenters/nurse_centers_login.dart';

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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextFormField(
                        controller: adminNameController,
                        cursorColor: Color(0xFF1C8892),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          hintText: "Admin Name",
                          filled: true,
                          fillColor: Color(0xFFF2F5F5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFFF2F5F5),
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Please enter your name correctly ";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextFormField(
                          controller: adminEmailController,
                          cursorColor: Color(0xFF1C8892),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.email,
                              color: Color(0xFF1C8892),
                            ),
                            hintText: "Email",
                            filled: true,
                            fillColor: Color(0xFFF2F5F5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFFF2F5F5),
                              ),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextFormField(
                        cursorColor: Color(0xFF1C8892),
                        obscureText: showHidePassword,
                        controller: adminPasswordController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            color: Color(0xFF1C8892),
                            onPressed: () {
                              setState(() {
                                showHidePassword = !showHidePassword;
                              });
                            },
                            icon: Icon(showHidePassword
                                ? Icons.remove_red_eye
                                : Icons.visibility_off),
                          ),
                          hintText: "Password",
                          filled: true,
                          fillColor: Color(0xFFF2F5F5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFFF2F5F5),
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        // validator: (value) {
                        //   RegExp regex = RegExp(
                        //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        //   var passNonNullValue = value ?? "";
                        //   if (passNonNullValue.isEmpty) {
                        //     return ("Password is required");
                        //   } else if (passNonNullValue.length < 9) {
                        //     return ("Password Must be more than 8 characters");
                        //   } else if (!regex
                        //       .hasMatch(passNonNullValue)) {
                        //     return ("Password should contain upper,lower,digit and Special character ");
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextFormField(
                        cursorColor: Color(0xFF1C8892),
                        obscureText: showHidePassword,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          hintText: "Confirm Password",
                          filled: true,
                          fillColor: Color(0xFFF2F5F5),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFFF2F5F5),
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm Password is required";
                          } else if (value != adminPasswordController.text) {
                            return 'The password does not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1C8892),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  User? newUser =
                                      await MyFirebaseAuth().createAccount(
                                    email: adminEmailController.text,
                                    password: adminPasswordController.text,
                                    context: context,
                                  );

                                  if (newUser != null) {
                                    CollectionReference centers =
                                        FirebaseFirestore.instance
                                            .collection('centers');
                                    await centers.doc(newUser.uid).set({
                                      'Admin': adminNameController.text,
                                      'Email': adminEmailController.text,
                                    });

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CentersHome(
                                          centerEmail:
                                              adminEmailController.text,
                                        ),
                                      ),
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Color(0xFF1C8892),
                                        behavior: SnackBarBehavior.floating,
                                        content: Text(
                                          "Logged In Successfully",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } catch (e) {
                                  print("Error: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      // backgroundColor: Colors.black,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        "Failed to create account: $e",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily:
                                              GoogleFonts.poppins().fontFamily,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Log In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
