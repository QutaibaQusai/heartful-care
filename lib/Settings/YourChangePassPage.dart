import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YourChangePassPage extends StatefulWidget {
  const YourChangePassPage({Key? key}) : super(key: key);

  @override
  State<YourChangePassPage> createState() => _YourChangePassPageState();
}

class _YourChangePassPageState extends State<YourChangePassPage> {
  bool showCurrentPassword = false;
  bool showNewPassword = false;
  TextEditingController currentPassword = new TextEditingController();
  TextEditingController newPassword = new TextEditingController();
  TextEditingController confirmNewPassword = new TextEditingController();
  bool isPasswordEightCharacters = false;
  bool hasPasswordOneNumber = false;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
                ),
                SizedBox(height: 16),
                TextField(
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
                ),
                SizedBox(height: 16),
                TextField(
                  controller: confirmNewPassword,
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
                  'Password must be:',
                  style: TextStyle(color: Colors.grey),
                ),
                // Text(
                //   '- 1 Uppercase letter (A-Z)\n- 1 Lowercase letter (a-z)\n- 1 number (0-9)\n- 1 special character',
                //   style: TextStyle(color: Colors.grey),
                // ),
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
                  height: 50, // Set the height of the button
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your submit logic here
                      if (currentPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xFF1C8892),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Please enter current password",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        );
                      } else if (newPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xFF1C8892),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Please enter new password",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        );
                      } else if (confirmNewPassword.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xFF1C8892),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              " Please re-type your password agin",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        );
                      } else if (newPassword.text != confirmNewPassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Color(0xFF1C8892),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Password does not match. Please re-type again",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ),
                        );
                        // }
                        //else if (isPasswordEightCharacters = false) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: Color(0xFF1C8892),
                        //       behavior: SnackBarBehavior.floating,
                        //       content: Text(
                        //         "your password must be contain at lest 8 char",
                        //         style: TextStyle(
                        //             fontSize: 17,
                        //             fontFamily: GoogleFonts.poppins().fontFamily),
                        //       ),
                        //     ),
                        //   );
                        // } else if (hasPasswordOneNumber = false) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: Color(0xFF1C8892),
                        //       behavior: SnackBarBehavior.floating,
                        //       content: Text(
                        //         "your password must be contain at lest 1 number",
                        //         style: TextStyle(
                        //             fontSize: 17,
                        //             fontFamily: GoogleFonts.poppins().fontFamily),
                        //       ),
                        //     ),
                        //   );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Set the border radius
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
