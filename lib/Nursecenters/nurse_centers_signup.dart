import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/Nursecenters/nurse_centers_login.dart';

class CentersSignUp extends StatefulWidget {
  const CentersSignUp({super.key});

  @override
  State<CentersSignUp> createState() => _CentersSignUpState();
}

class _CentersSignUpState extends State<CentersSignUp> {
  bool showHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // backgroundColor: const Color(0xFFE8ECF4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => centersLogin(),
                            ),
                          );
                        },
                        icon: const Icon(
                          CupertinoIcons.back,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello! Register to get  \nstarted",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C8892),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              // controller: centerEmailController,
                              decoration: InputDecoration(
                                labelText: "Admin",
                                hintText: "Enter your Name",
                                contentPadding: EdgeInsets.all(18),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              // controller: ,
                              decoration: InputDecoration(
                                labelText: "Email",
                                hintText: "Enter your Email",
                                contentPadding: EdgeInsets.all(18),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              obscureText: showHidePassword,
                              // controller: centerPasswordController,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                    color: Color(0xFF1C8892),
                                    onPressed: () {
                                      setState(() {});
                                      showHidePassword = !showHidePassword;
                                    },
                                    icon: Icon(showHidePassword
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off),
                                  ),
                                ),
                                labelText: "Password",
                                hintText: "Enter your password",
                                contentPadding: EdgeInsets.all(18),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Confirm password",
                                hintText: "Confirm your password",
                                contentPadding: EdgeInsets.all(18),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Handle forgot password logic
                                  },
                                  child: Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF1C8892)),
                                      side: MaterialStateProperty.all(
                                          BorderSide(color: Color(0xFF1C8892))),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size.fromWidth(370)),
                                      padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(vertical: 20),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // New Row for "Don’t have an account?" and "Register now"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => centersLogin()));
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Color(0xFF1C8892),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
