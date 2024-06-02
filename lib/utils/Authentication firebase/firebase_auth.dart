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

  // forget password
  Future forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    // trim method to remove space
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

  // update Email
  Future<void> updateEmailWithoutVerification({
    required BuildContext context,
    required String oldEmail,
    required String newEmail,
    required String password,
  }) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            content: Text(
              "No user is currently signed in.",
              style: TextStyle(fontSize: 17),
            ),
          ),
        );
        return;
      }

      // Reauthenticate the user
      final AuthCredential credential = EmailAuthProvider.credential(
        email: oldEmail,
        password: password,
      );

      await currentUser.reauthenticateWithCredential(credential);

      // Update the email
      await currentUser.updateEmail(newEmail);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text(
            "Email updated successfully",
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is incorrect.';
          break;
        case 'user-mismatch':
          errorMessage =
              'The provided credentials do not match the current user.';
          break;
        case 'requires-recent-login':
          errorMessage =
              'You need to log in again before you can update your email.';
          break;
        default:
          errorMessage = 'Failed to update email: ${e.message}';
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
      print('FirebaseAuthException: ${e.code} - ${e.message}');
    } catch (e) {
      print('General Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          content: Text(
            "An unexpected error occurred",
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }

  // update password
  Future<void> changePassword({
    required BuildContext context,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Reauthenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: currentUser.email ?? '',
          password: currentPassword,
        );

        await currentUser.reauthenticateWithCredential(credential);

        // Update the password
        await currentUser.updatePassword(newPassword);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF1C8892),
            behavior: SnackBarBehavior.floating,
            content: Text(
              "Password updated successfully",
              style: TextStyle(fontSize: 17),
            ),
          ),
        );
      } else {
        throw FirebaseAuthException(
            code: 'user-not-logged-in',
            message: 'No user is currently logged in.');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'The current password is incorrect.';
          break;
        case 'weak-password':
          errorMessage = 'The new password is too weak.';
          break;
        case 'requires-recent-login':
          errorMessage =
              'You need to log in again before you can update your password.';
          break;
        case 'user-not-logged-in':
          errorMessage = 'No user is currently logged in.';
          break;
        default:
          errorMessage = 'Failed to update password: ${e.message}';
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xFF1C8892),
          behavior: SnackBarBehavior.floating,
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 17),
          ),
        ),
      );
    }
  }
}
