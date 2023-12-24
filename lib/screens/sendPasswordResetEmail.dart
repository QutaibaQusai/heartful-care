import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/utils/firebase_auth.dart';

class SendPasswordResetEmail extends StatefulWidget {
  const SendPasswordResetEmail({super.key});

  @override
  State<SendPasswordResetEmail> createState() => _SendPasswordResetEmailState();
}

class _SendPasswordResetEmailState extends State<SendPasswordResetEmail> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "images/logo.png",
              width: 150,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Forget Password",
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              "Reset your password and follow the instructions sent to your email to regain access to your account.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 16),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Color(0xFF1C8892)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF1C8892)),
                    borderRadius: BorderRadius.circular(0)),
                hintText: "Enter your email",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: MaterialButton(
                  onPressed: () {
                    MyFirebaseAuth().forgetPassword(
                        email: emailController.text, context: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Rest password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ),
                  color: Color(
                    0xFF1C8892,
                  ),
                )),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
