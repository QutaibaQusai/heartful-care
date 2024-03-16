import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Authentication%20firebase/firebase_auth.dart';
import 'package:test/Medical%20Devices/supplier_home.dart';

class SignUpSupplier extends StatefulWidget {
  const SignUpSupplier({Key? key}) : super(key: key);

  @override
  _SignUpSupplierState createState() => _SignUpSupplierState();
}

class _SignUpSupplierState extends State<SignUpSupplier> {
  TextEditingController supplierName = TextEditingController();
  TextEditingController supplierEmail = TextEditingController();
  TextEditingController supplierPassword = TextEditingController();
  bool showHidePassword = true;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign up",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    controller: supplierName,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    controller: supplierEmail,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    controller: supplierPassword,
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
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
                            try {
                              User? newUser =
                                  await MyFirebaseAuth().createAccount(
                                email: supplierEmail.text,
                                password: supplierPassword.text,
                                context: context,
                              );

                              if (newUser != null) {
                                CollectionReference centers = FirebaseFirestore
                                    .instance
                                    .collection('Suppliers');
                                await centers.doc(newUser.uid).set({
                                  'Admin': supplierName.text,
                                  'Email': supplierEmail.text,
                                  // You can add other fields here as necessary
                                });

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SuppliersHome(
                                      supplierEmail: supplierEmail.text,
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
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            } catch (e) {
                              print("Error: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
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
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Sign Up",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
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
      ),
    );
  }
}
