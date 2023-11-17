import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  //final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Forgot Password'),
          ),
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forget \nPassword",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            letterSpacing: 1),
                      ),
                      Text(
                        "Select which contact details should we use to reset your password:",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2.4,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            //fontWeight: FontWeight.w600,
                            color: Colors.grey[700]),
                      )
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
