import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:test/utils/Authentication%20firebase/firebase_auth.dart'; // Import Lottie package

class ResetPasswordSupplier extends StatefulWidget {
  const ResetPasswordSupplier({Key? key});

  @override
  State<ResetPasswordSupplier> createState() => _ResetPasswordSupplierState();
}

class _ResetPasswordSupplierState extends State<ResetPasswordSupplier> {
  final TextEditingController emailController = TextEditingController();
  final formKey1 =
      GlobalKey<FormState>(); // Use FormState instead of FormFieldState

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: formKey1, // Assign the key to the Form widget
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('images/resetPassword-suppliers.json',
                      width: 300),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Forget Password",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Reset your password and follow the instructions sent to your email to regain access to your account.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    cursorColor: Color(0xFF1C8892),
                    controller: emailController,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFF1C8892),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF1C8892),
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      hintText: "Enter your email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFF1C8892)),
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
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () async {
                            if (formKey1.currentState!.validate()) {
                              // Replace MyFirebaseAuth with your authentication logic
                              await MyFirebaseAuth().forgetPassword(
                                email: emailController.text,
                                context: context,
                              );
                              // Display a Snackbar message for demonstration
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Color(0xFF1C8892),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Check your email',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                    ),
                                  ),
                                ),
                              );
                            }
                            emailController.clear();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Reset password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          color: Color(0xFF1C8892),
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
    );
  }
}
