import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/Home.dart';
import 'package:test/utils/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreen();
}

class _SignInScreen extends State<SignInScreen> {
  final passwordTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final fullNameTextController = TextEditingController();
  bool showHidePassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 25),
            child: Form(
              key: formKey,
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
                              letterSpacing: 1),
                        ),
                        Text(
                          "Signup into your account",
                          style: TextStyle(
                              fontSize: 17,
                              height: 2.4,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height / 1.6,
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
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: fullNameTextController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                errorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.red),
                                ),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red)),
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
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                return "Please enter your name correctly ";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: emailTextController,
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  errorBorder: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.red)),
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your email address";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return "Please enter a valid email address";
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(color: Colors.white),
                            obscureText: showHidePassword,
                            controller: passwordTextController,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              errorBorder: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Color(0xffd32f2f)),
                              ),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Color(0xffd32f2f))),
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
                              ),
                              enabledBorder: OutlineInputBorder(
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
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              var passNonNullValue = value ?? "";
                              if (passNonNullValue.isEmpty) {
                                return ("Password is required");
                              } else if (passNonNullValue.length < 9) {
                                return ("Password Must be more than 8 characters");
                              } else if (!regex.hasMatch(passNonNullValue)) {
                                return ("Password should contain upper,lower,digit and Special character ");
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 18.0,
                                      right: 18.0,
                                      bottom: 5),
                                  child: ElevatedButton(
                                    style: ButtonStyle(),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        CollectionReference users =
                                            FirebaseFirestore.instance
                                                .collection('users');
                                        users.add({
                                          'fullname':
                                              fullNameTextController.text,
                                          'email': emailTextController.text,
                                          //'password': passwordTextController.text
                                        });

                                        var x = await MyFirebaseAuth()
                                            .createAccount(
                                                email: emailTextController.text,
                                                password:
                                                    passwordTextController.text,
                                                context: context);
                                        if (x != null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                SnackBar(
                                                  backgroundColor:
                                                      Color(0xFF1C8892),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                    "Logged In Successfully",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontFamily: GoogleFonts
                                                                .poppins()
                                                            .fontFamily),
                                                  ),
                                                ),
                                              )
                                              .closed
                                              .whenComplete(() =>
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Home(
                                                          userEmail:
                                                              emailTextController
                                                                  .text),
                                                    ),
                                                  ));
                                        }
                                      }
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
        floatingActionButton: CircleAvatar(
            backgroundColor: Color(0xFF1C8892),
            radius: 30,
            child: MaterialButton(
              onPressed: () {
                showBottomSheet();
              },
              child: Icon(
                FontAwesomeIcons.unlock,
                color: Colors.white,
              ),
            )),
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
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => LogInScreen()),
              //     (Route<dynamic> route) => false);
              Navigator.pop(context);
            },
            child: Text(
              " Log in ",
              style: TextStyle(
                color: const Color(0xFF1C8892),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
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
              children: [Text("data")],
            ),
          ),
        );
      },
    );
  }
}
