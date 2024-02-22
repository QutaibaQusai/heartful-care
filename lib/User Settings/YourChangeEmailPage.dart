import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test/Authentication%20firebase/firebase_auth.dart';

class YourChangeEmailPage extends StatefulWidget {
  final String userEmail;

  const YourChangeEmailPage({Key? key, required this.userEmail})
      : super(key: key);

  @override
  State<YourChangeEmailPage> createState() => _YourChangeEmailPageState();
}

class _YourChangeEmailPageState extends State<YourChangeEmailPage> {
  Color underlineColor = Colors.grey;
  bool showPassword = false;
  TextEditingController newEmail = TextEditingController();
  TextEditingController oldEmail = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Add this line to initialize MyFirebaseAuth
  MyFirebaseAuth myFirebaseAuth = MyFirebaseAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text("user email " + widget.userEmail),
              TextField(
                controller: oldEmail,
                decoration: InputDecoration(
                  labelText: 'old email',
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
                      obscureText: !showPassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: underlineColor),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              showPassword ? 'Hide' : 'Show',
                              style: TextStyle(
                                color: Color(0xFF1C8892),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
                  onPressed: () {
                    print(newEmail.text);
                    print(oldEmail.text);
                    print(passwordController.text);

                    if (newEmail.text.isNotEmpty &&
                        oldEmail.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      myFirebaseAuth.changeEmail(
                        context: context,
                        newEmail: newEmail.text.trim(),
                        password: passwordController.text,
                      );

                      _submitUserData();
                    } else {
                      // Handle empty fields error
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Color(0xFF1C8892),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitUserData() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Find the user document
      var userDoc =
          await users.where('email', isEqualTo: widget.userEmail).get();

      if (userDoc.docs.isNotEmpty) {
        var userId = userDoc.docs[0].id;

        // Update the existing document with the new data
        await users.doc(userId).update({
          'email': newEmail.text,
        });

        print("+++++++++++++++++++++++++++++++");
      } else {
        print("----------");
      }
    } catch (e) {}
  }
}
