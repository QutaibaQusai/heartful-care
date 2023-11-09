import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Home.dart';
import 'package:test/screens/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool showHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/logo2.png",
            ),
            const SizedBox(
              height: 30,
            ),
            // calling methods
            TextField(
              controller: _emailTextController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Color(0xFF1C8892),
                  ),
                  labelText: "UserName",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: showHidePassword,
              controller: _passwordTextController,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF1C8892),
                  ),
                  labelText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {});
                        showHidePassword = !showHidePassword;
                      },
                      icon: Icon(showHidePassword
                          ? Icons.remove_red_eye
                          : Icons.visibility_off),
                    ),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: GoogleFonts.poppins().fontFamily),
                  ),
                ),
              ],
            ),

            signInSignUpButton(
              context,
              "LOG IN",
              () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            signUpOption(),
          ],
        ),
      ),
    );
  }

// this method for the sign up option in the right
  Widget signUpOption() {
    return Row(
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: Text(
            " Sign Up".toUpperCase(),
            style: TextStyle(
                color: const Color(0xFF1C8892),
                fontWeight: FontWeight.bold,
                fontSize: 17,
                fontFamily: GoogleFonts.poppins().fontFamily),
          ),
        )
      ],
    );
  }
}

// this method for the LOG IN button
Widget signInSignUpButton(BuildContext context, String title, Function onTap) {
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
}
