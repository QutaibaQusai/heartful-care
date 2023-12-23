import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFirebaseAuth {
  // firebase instance
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential>? createAccount(
      {required BuildContext context,
      required String email,
      required String password}) {
    try {
      return auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
}
