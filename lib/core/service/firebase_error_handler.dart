import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteradv6/core/service/app_messages.dart';

class FirebaseErrorHandler {
  static void handleError(dynamic error) {
    String errorMessage;

    if (error is FirebaseAuthException) {
      switch (error.code) {
        // Sign-up related errors
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Operation not allowed. Please contact support.';
          break;
        case 'weak-password':
          errorMessage =
              'The password is too weak. Please choose a stronger password.';
          break;

        // Sign-in related errors
        case 'user-disabled':
          errorMessage = 'The user account has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email address.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is incorrect.';
          break;

        // Password reset and password change errors
        case 'invalid-credential':
          errorMessage =
              'The supplied auth credential is incorrect, malformed, or has expired.';
          break;
        case 'requires-recent-login':
          errorMessage =
              'This operation is sensitive and requires a recent login. Please sign in again.';
          break;

        // Re-authentication specific errors
        case 'too-many-requests':
          errorMessage =
              'We have blocked all requests from this device due to unusual activity. Try again later.';
          break;
        case 'network-request-failed':
          errorMessage =
              'A network error occurred. Please check your connection.';
          break;
        case 'internal-error':
          errorMessage = 'An internal error occurred. Please try again later.';
          break;

        // Multi-factor authentication errors
        case 'mfa-required':
          errorMessage =
              'Multi-factor authentication is required to complete the sign-in.';
          break;

        // Logout related errors
        case 'user-token-expired':
          errorMessage =
              'The user’s credential has expired. Please log in again.';
          break;
        case 'no-current-user':
          errorMessage = 'No user is currently signed in.';
          break;

        default:
          errorMessage =
              'An undefined error occurred. Error code: ${error.code}';
      }
    } else {
      errorMessage = 'An unknown error occurred.';
    }

    Messages.getSnackMessage("Error", errorMessage, Colors.red, 3);
  }
}
