import 'package:flutter/material.dart';
import 'package:test/utils/Authentication%20firebase/firebase_auth.dart';

class CenterChangeEmail extends StatefulWidget {
  const CenterChangeEmail({super.key});

  @override
  State<CenterChangeEmail> createState() => _CenterChangeEmailState();
}

class _CenterChangeEmailState extends State<CenterChangeEmail> {
  bool showHidePassword = false;
  TextEditingController passwordCenterController = TextEditingController();
  TextEditingController newCenterEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Change email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: newCenterEmail,
                  decoration: InputDecoration(
                    labelText: 'New email',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Confirm email',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: !showHidePassword,
                        controller: passwordCenterController,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await MyFirebaseAuth().changeEmail(
                          context: context,
                          newEmail: newCenterEmail.text,
                          password: passwordCenterController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      backgroundColor: Color(
                        0xFF1C8892,
                      ), // Text color
                    ),
                    child: Text('Submit'),
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
