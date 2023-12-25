import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFirebaseAuth {
  // firebase instance
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> createAccount(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      final error = e as FirebaseAuthException;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            error.message!,
            style: TextStyle(
                fontSize: 17, fontFamily: GoogleFonts.poppins().fontFamily),
          ),
        ),
      );
      return null;
    }
  }

  // method for signIn
  Future<User?> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      final error = e as FirebaseAuthException;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            error.message!,
            style: TextStyle(
                fontSize: 17, fontFamily: GoogleFonts.poppins().fontFamily),
          ),
        ),
      );
      return null;
    }
  }

  Future forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return Container(
      //       width: 100,
      //       height: 100,
      //       child: AlertDialog(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.zero,
      //         ),
      //         backgroundColor: Colors.white,
      //         content: Text(
      //           "Check your email",
      //           style: TextStyle(
      //             color: Colors.black,
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // );
      return await auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      final error = e as FirebaseAuthException;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Colors.white,
            content: Text(
              error.message!,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        },
      );
      return null;
    }
  }
}
