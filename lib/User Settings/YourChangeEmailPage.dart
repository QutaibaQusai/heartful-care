import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test/utils/Authentication%20firebase/firebase_auth.dart';

class YourChangeEmailPage extends StatefulWidget {
  const YourChangeEmailPage({Key? key, required String userEmail})
      : super(key: key);

  @override
  State<YourChangeEmailPage> createState() => _YourChangeEmailPageState();
}

class _YourChangeEmailPageState extends State<YourChangeEmailPage> {
  Color underlineColor = Colors.grey;
  bool showHidePassword = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController currentEmail = TextEditingController();
  TextEditingController newEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Change email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          centerTitle: true,
          leading: Container(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: currentEmail,
                  decoration: InputDecoration(
                    labelText: 'Old email',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: underlineColor),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: newEmail,
                  decoration: InputDecoration(
                    labelText: 'New email',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: underlineColor),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        obscureText: !showHidePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: underlineColor),
                          ),
                          suffixIcon: IconButton(
                            color: Color(0xFF1C8892),
                            onPressed: () {
                              setState(() async {
                                showHidePassword = !showHidePassword;
                                await MyFirebaseAuth()
                                    .updateEmailWithoutVerification(
                                        context: context,
                                        oldEmail: currentEmail.text,
                                        newEmail: newEmail.text,
                                        password: passwordController.text);
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
                    onPressed: () {},
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
