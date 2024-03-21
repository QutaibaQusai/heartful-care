import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/utils/Authentication%20firebase/firebase_auth.dart';
import 'package:test/Medical%20Devices/sendPassordResetEmailSuppliers.dart';
import 'package:test/Medical%20Devices/sginUpSupplier.dart';
import 'package:test/Medical%20Devices/supplier_home.dart';

class SupplierRegistration extends StatefulWidget {
  const SupplierRegistration({Key? key});

  @override
  State<SupplierRegistration> createState() => _SupplierRegistrationState();
}

class _SupplierRegistrationState extends State<SupplierRegistration> {
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
                      "Welcome back!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ],
                ),
                Image.asset('images/logo2.png'),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: TextField(
                    controller: supplierEmail,
                    cursorColor: Color(0xFF1C8892),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      hintText: "Email",
                      filled: true,
                      fillColor: Color(0xFFF2F5F5),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFF2F5F5)),
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
                        borderRadius: BorderRadius.circular(0),
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
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFF2F5F5)),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showBottomSheet(context); // Pass the context parameter
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
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
                            final x = await MyFirebaseAuth().signIn(
                                context: context,
                                email: supplierEmail.text,
                                password: supplierPassword.text);
                            if (x != null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
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
                                      duration: Duration(
                                          seconds:
                                              1), // Set your custom duration here
                                    ),
                                  )
                                  .closed
                                  .whenComplete(
                                    () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SuppliersHome(
                                          supplierEmail: supplierEmail.text,
                                        ),
                                      ),
                                    ),
                                  );
                            }
                            // supplierEmail.clear();
                            // supplierPassword.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Log in",
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
                    text: "New supplier? ",
                    style: TextStyle(fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Replace SignUpSupplier with your destination widget
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpSupplier(),
                              ),
                            );
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

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
      ),
      builder: (context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forget \nPassword",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Color(0xFF1C8892)),
                ),
                Text(
                  "Select which contact details should we use to reset your password:",
                  style: TextStyle(
                      fontSize: 17, height: 1.6, color: Colors.grey[700]),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResetPasswordSupplier()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF1C8892),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.white,
                            size: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "E-mail:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    height: 1.8),
                              ),
                              Text(
                                "Reset via Mail Verification.",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
