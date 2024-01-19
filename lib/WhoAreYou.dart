import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:test/screens/login_screen.dart';

class WhoAreYou extends StatefulWidget {
  const WhoAreYou({super.key});

  @override
  State<WhoAreYou> createState() => _WhoAreYou();
}

class _WhoAreYou extends State<WhoAreYou> {
  String selectedOption = 'Users'; // Default value

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Who are you?",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        "Please select one of options to explore the app",
                        style: TextStyle(
                            fontSize: 12,
                            height: 4,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600]),
                      ),
                      Lottie.asset(
                          'images/lottie/Animation - 1705675942310.json'),
                      SizedBox(height: 30),
                      Container(
                        child: DropdownButton<String>(
                          value: selectedOption,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Color(0xFF1C8892),
                            fontSize: 16, // Text size
                            fontWeight: FontWeight.w500,
                          ),
                          underline: Container(
                            height: 0,
                          ),
                          onChanged: (String? selectedValue) {
                            if (selectedValue != null) {
                              setState(() {
                                selectedOption = selectedValue;
                              });

                              // Navigate to login page if "Users" is selected
                              if (selectedValue == 'Users') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogInScreen(),
                                  ),
                                );
                              }
                            }
                          },
                          items: <String>[
                            'Users',
                            'Nurse centers',
                            'Medical Devices Suppliers',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
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
}
