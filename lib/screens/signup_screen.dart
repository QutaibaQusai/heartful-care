import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:test/Home.dart';
import 'package:test/screens/login_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _fullNameTextController = TextEditingController();
  bool showHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
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
                        "Welcome",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            letterSpacing: 1),
                      ),
                      Text(
                        "Signup into your account",
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
                          "Sign Up",
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
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                          controller: _fullNameTextController,
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
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              labelText: "Full Name",
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily:
                                      GoogleFonts.poppins().fontFamily)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.poppins().fontFamily),
                          controller: _emailTextController,
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
                          style: TextStyle(color: Colors.white),
                          obscureText: showHidePassword,
                          controller: _passwordTextController,
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
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 18.0, right: 18.0, bottom: 5),
                                child: ElevatedButton(
                                  style: ButtonStyle(),
                                  onPressed: () {
                                    // Navigate to the second page when the button is pressed
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (ctx) {
                                      return const LogInScreen();
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    child: Text(
                                      "SIGN UP",
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
            "Already have an account?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: GoogleFonts.poppins().fontFamily),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LogInScreen()));
            },
            child: Text(
              " Log in ",
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
}

/*Container SignInSignUpButton(
    BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return const Color(0xFF1C8892);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}*/