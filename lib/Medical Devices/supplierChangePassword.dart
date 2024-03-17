import 'package:flutter/material.dart';
import 'package:test/Authentication%20firebase/firebase_auth.dart';

class SupplierChangePassword extends StatefulWidget {
  const SupplierChangePassword({super.key});

  @override
  State<SupplierChangePassword> createState() => _SupplierChangePasswordState();
}

class _SupplierChangePasswordState extends State<SupplierChangePassword> {
  bool showCurrentPassword = false;
  bool showHidePassword = false;
  TextEditingController currentSupplierPassword = TextEditingController();
  TextEditingController newSupplierPassword = TextEditingController();
  TextEditingController confirmNewSupplierPassword = TextEditingController();
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;
  final formKey = GlobalKey<FormState>();
  bool checkCurrentPasswordValid = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Change password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: currentSupplierPassword,
                      obscureText: !showCurrentPassword,
                      decoration: InputDecoration(
                        labelText: 'Current password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          color: Color(0xFF1C8892),
                          onPressed: () {
                            setState(() {
                              showCurrentPassword = !showCurrentPassword;
                            });
                          },
                          icon: Icon(showCurrentPassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off),
                        ),
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Please enter your current password";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      onChanged: (password) => onPasswordChange(password),
                      controller: newSupplierPassword,
                      obscureText: !showHidePassword,
                      decoration: InputDecoration(
                        labelText: 'New password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
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
                      ),
                      // validator: (value) {
                      //   RegExp regex = RegExp(
                      //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      //   var passNonNullValue = value ?? "";
                      //   if (passNonNullValue.isEmpty) {
                      //     return ("Password is required");
                      //   } else if (passNonNullValue.length < 9) {
                      //     return ("Password Must be more than 8 characters");
                      //   } else if (!regex.hasMatch(passNonNullValue)) {
                      //     return ("Password should contain upper,lower,digit and Special character ");
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: confirmNewSupplierPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm new password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      //   validator: (value) {
                      //     return newSupplierPassword.text == value
                      //         ? null
                      //         : "please validate your intend password";
                      //   },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await MyFirebaseAuth().changePassword(
                                context: context,
                                currentPassword: currentSupplierPassword.text,
                                newPassword: newSupplierPassword.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF1C8892),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  onPasswordChange(String password) {
    final numericRegex = RegExp(r'[0-9]');
    setState(() {
      isPasswordEightCharacters = false;
      if (password.length >= 8) {
        isPasswordEightCharacters = true;
      }

      hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) {
        hasPasswordOneNumber = true;
      }
    });
  }
}
