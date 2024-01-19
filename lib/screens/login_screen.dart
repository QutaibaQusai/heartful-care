import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/home.dart';
import 'package:test/screens/sendPasswordResetEmail.dart';
import 'package:test/screens/signup_screen.dart';
import 'package:test/utils/firebase_auth.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  bool showHidePassword = true;

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
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            letterSpacing: 1),
                      ),
                      Text(
                        "Login back into your account",
                        style: TextStyle(
                            fontSize: 17,
                            height: 2.4,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Color(0xFF1C8892),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70),
                        topRight: Radius.circular(70),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log in",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                          controller: emailTextController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Set the border color to white when focused
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(
                                  color: Colors
                                      .white, // Set the border color to white when not focused
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.mail_outline,
                                color: Colors.white,
                              ),
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily:
                                      GoogleFonts.poppins().fontFamily)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.white),
                          obscureText: showHidePassword,
                          controller: passwordTextController,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                color: Colors
                                    .white, // Set the border color to white when focused
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                color: Colors
                                    .white, // Set the border color to white when not focused
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  setState(() {});
                                  showHidePassword = !showHidePassword;
                                },
                                icon: Icon(showHidePassword
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                showBottomSheet();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             ForgotPasswordScreen()));
                              },
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 18.0, right: 18.0, bottom: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(),
                                  onPressed: () async {
                                    if (emailTextController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Color(0xFF1C8892),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Please Enter your E-mail",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily),
                                          ),
                                        ),
                                      );
                                    } else if (passwordTextController
                                        .text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Color(0xFF1C8892),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Please Enter your Password",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily),
                                          ),
                                        ),
                                      );
                                    } else {
                                      // final fullName = await MyFirebaseAuth().getFullName(emailTextController.text);
                                      final x = await MyFirebaseAuth().signIn(
                                          context: context,
                                          email: emailTextController.text,
                                          password:
                                              passwordTextController.text);
                                      if (x != null) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(
                                                userEmail:
                                                    emailTextController.text),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

// this method for the sign up option in the right
  Widget signUpOption() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have account?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: GoogleFonts.poppins().fontFamily),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => SignInScreen()),
              //     (Route<dynamic> route) => false);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
            child: Text(
              " sign up ".toUpperCase(),
              style: TextStyle(
                  color: const Color(0xFF1C8892),
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  fontFamily: GoogleFonts.poppins().fontFamily),
            ),
          )
        ],
      ),
    );
  }

  showBottomSheet() {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.0)),
      ),
      builder: (context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forget \nPassword",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      letterSpacing: 1,
                      color: Color(0xFF1C8892)),
                ),
                Text(
                  "Select which contact details should we use to reset your password:",
                  style: TextStyle(
                      fontSize: 17,
                      height: 1.6,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      //fontWeight: FontWeight.w600,
                      color: Colors.grey[700]),
                ),
                SizedBox(
                  height: 30,
                )

                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                //     decoration: BoxDecoration(
                //         color: Color(0xFF1C8892),
                //         borderRadius: BorderRadius.circular(20)),
                //     child: Padding(
                //       padding: const EdgeInsets.only(top: 40, bottom: 40),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Icon(
                //             FontAwesomeIcons.mobileScreenButton,
                //             color: Colors.white,
                //             size: 50,
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 "Via sms:",
                //                 style: TextStyle(
                //                     fontSize: 16,
                //                     color: Colors.white,
                //                     fontFamily:
                //                         GoogleFonts.poppins().fontFamily,
                //                     height: 1.8),
                //               ),
                //               Text(
                //                 "+962 **********",
                //                 style: TextStyle(
                //                   fontSize: 18,
                //                   fontFamily: GoogleFonts.poppins().fontFamily,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //             ],
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                ,
                InkWell(
                  onTap: () {
                    //TODO
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SendPasswordResetEmail()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF1C8892),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.white,
                            size: 50,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "E-mail:",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    height: 1.8),
                              ),
                              Text(
                                "Reset via Mail Verification.",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
