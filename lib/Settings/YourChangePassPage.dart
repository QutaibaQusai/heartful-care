import 'package:flutter/material.dart';

class YourChangePassPage extends StatefulWidget {
  const YourChangePassPage({Key? key}) : super(key: key);

  @override
  State<YourChangePassPage> createState() => _YourChangePassPageState();
}

class _YourChangePassPageState extends State<YourChangePassPage> {
  bool showCurrentPassword = false;
  bool showNewPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change password',
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
              ),
              SizedBox(height: 16),
              TextField(
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
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm new password',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Password must be at least 8 characters and should include:',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '- 1 Uppercase letter (A-Z)\n- 1 Lowercase letter (a-z)\n- 1 number (0-9)\n- 1 special character',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50, // Set the height of the button
                child: ElevatedButton(
                  onPressed: () {
                    // Add your submit logic here
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set the border radius
                    ),
                    primary: Color(0xFF1C8892), // Background color
                    onPrimary: Colors.white, // Text color
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
