import 'package:flutter/material.dart';
import 'package:test/Authentication%20firebase/firebase_auth.dart';

class YourChangePassPage extends StatefulWidget {
  const YourChangePassPage({Key? key}) : super(key: key);

  @override
  State<YourChangePassPage> createState() => _YourChangePassPageState();
}

class _YourChangePassPageState extends State<YourChangePassPage> {
  bool showCurrentPassword = false;
  bool showNewPassword = false;
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: currentPassword,
                      obscureText: !showCurrentPassword,
                      decoration: InputDecoration(
                        labelText: 'Current password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showCurrentPassword = !showCurrentPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              showCurrentPassword ? 'Hide' : 'Show',
                              style: TextStyle(
                                color: Color(0xFF1C8892),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your current password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      onChanged: (password) => onPasswordChange(password),
                      controller: newPassword,
                      obscureText: !showNewPassword,
                      decoration: InputDecoration(
                        labelText: 'New password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showNewPassword = !showNewPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              showNewPassword ? 'Hide' : 'Show',
                              style: TextStyle(
                                color: Color(0xFF1C8892),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
                        } else if (!regex.hasMatch(passNonNullValue)) {
                          return ("Password should contain upper,lower,digit and Special character ");
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: confirmNewPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm new password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        return newPassword.text == value
                            ? null
                            : "please validate your intend password";
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Password must be:',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isPasswordEightCharacters
                                ? Color(0xFF1C8892)
                                : Colors.transparent,
                            border: isPasswordEightCharacters
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Contain at least 8 characters",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: hasPasswordOneNumber
                                ? Color(0xFF1C8892)
                                : Colors.transparent,
                            border: hasPasswordOneNumber
                                ? Border.all(color: Colors.transparent)
                                : Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Contains at least 1 number",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
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
                                currentPassword: currentPassword.text,
                                newPassword: newPassword.text
                                // currentPassword.text,
                                // newPassword.text,
                                );
                          }
                          Navigator.pop(context);
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
    );
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
