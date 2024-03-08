import 'package:flutter/material.dart';

class YourChangeEmailPage extends StatefulWidget {
  const YourChangeEmailPage({Key? key, required String userEmail})
      : super(key: key);

  @override
  State<YourChangeEmailPage> createState() => _YourChangeEmailPageState();
}

class _YourChangeEmailPageState extends State<YourChangeEmailPage> {
  Color underlineColor = Colors.grey; // Initial color for the underline
  bool showHidePassword = false;

  TextEditingController passwordController = TextEditingController();

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
              TextField(
                decoration: InputDecoration(
                  labelText: 'New email',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: underlineColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm email',
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
                  onPressed: () {
                    // Add your submit logic here
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
    );
  }
}
