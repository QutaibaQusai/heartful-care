import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              fontSize: 17,
            ),
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
              fontSize: 17,
            ),
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

  Future<void> changePassword(
      {required BuildContext context,
      required String currentPassword,
      required String newPassword}) async {
    try {
      User? currentUser = auth.currentUser;

      final AuthCredential credential = EmailAuthProvider.credential(
        email: currentUser?.email ?? '',
        password: currentPassword,
      );

      await currentUser?.reauthenticateWithCredential(credential);

      await currentUser?.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Password updated successfully",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );

      print(
          '__________________Password updated successfully____________________');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to update password",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
      print('______________Failed to update password:_____________ $e');
    }
  }

  Future<void> changeEmail({
    required BuildContext context,
    required String newEmail,
    required String password,
  }) async {
    try {
      User? currentUser = auth.currentUser;

      final AuthCredential credential = EmailAuthProvider.credential(
        email: currentUser?.email ?? '',
        password: password,
      );

      await currentUser?.reauthenticateWithCredential(credential);

      // Send verification email to the new email address
      await currentUser?.verifyBeforeUpdateEmail(newEmail);

      // Update the email after verification
      // await currentUser?.updateEmail(newEmail);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Email updated successfully to $newEmail",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
      print('Email updated successfully to $newEmail');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            "Failed to update email: ${e.message}",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      );
      print('Failed to update email: ${e.message}');
    }
  }
}
