import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

String getErrorMessage(FirebaseException exception) {
  switch (exception.code) {
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'user-disabled':
      return 'Your account has been disabled. Please contact support.';
    case 'user-not-found':
      return 'No account found for this email. Please create an account.';
    case 'wrong-password':
      return 'Incorrect email or password.';
    case 'too-many-requests':
      return 'Too many login attempts. Please try again later.';
    case 'operation-not-allowed':
      return 'This sign-in method is not enabled for this app.';
    case 'account-exists-with-different-credential':
      return 'An account already exists with this email address using a different sign-in method.';
    case 'email-already-in-use':
      return 'This email address is already in use.';
    default:
      return 'An error occurred during sign in. Please try again.';
  }
}

String getExceptionMessage(dynamic exception) {
  String errorMessage;
  switch (exception.runtimeType) {
    case FirebaseAuthException _:
      FirebaseAuthException authException = exception;
      switch (authException.code) {
        case 'user-not-found':
          errorMessage =
              'User not found. Please check your email and try again.';
          break;
        case 'wrong-password':
          errorMessage = 'Invalid password. Please try again.';
          break;
        case 'email-already-in-use':
          errorMessage = 'Email already in use. Please use a different email.';
          break;
        // Add more cases as needed for different Firebase authentication exceptions
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }
      break;
    case PlatformException _:
      PlatformException platformException = exception;
      switch (platformException.code) {
        case 'ERROR_INVALID_EMAIL':
          errorMessage =
              'Invalid email format. Please enter a valid email address.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          errorMessage = 'Too many requests. Please try again later.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again later.';
      }
      break;
    default:
      errorMessage = 'An error occurred. Please try again later.';
  }
  return errorMessage;
}