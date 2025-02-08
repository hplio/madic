import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:madic/auth/firebase_exception.dart';
import 'package:madic/auth/user/user_repo.dart';
import 'package:madic/screen/login_screen.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw getErrorMessage(e);
    } on FormatException catch (e) {
      throw getExceptionMessage(e);
    } on PlatformException catch (e) {
      throw getExceptionMessage(e);
    } on FirebaseException catch (e) {
      throw getErrorMessage(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw getErrorMessage(e);
    } on FormatException catch (e) {
      throw getExceptionMessage(e);
    } on PlatformException catch (e) {
      throw getExceptionMessage(e);
    } on FirebaseException catch (e) {
      throw getErrorMessage(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw getErrorMessage(e);
    } on FormatException catch (e) {
      throw getExceptionMessage(e);
    } on PlatformException catch (e) {
      throw getExceptionMessage(e);
    } on FirebaseException catch (e) {
      throw getErrorMessage(e);
    } catch (e) {
      if (kDebugMode) print(e.toString());
      throw 'Something went wrong. Please try again later.';
    }
  }

  logOut() async {
    try {
      final controller = Get.put(FirestoreService());
      await GoogleSignIn().signOut();
      await _auth.signOut();
      controller.user.value = null;
      Get.offAll(() => const SignInScreen());
    } on FirebaseAuthException catch (e) {
      throw getErrorMessage(e);
    } on FormatException catch (e) {
      throw getExceptionMessage(e);
    } on PlatformException catch (e) {
      throw getExceptionMessage(e);
    } on FirebaseException catch (e) {
      throw getErrorMessage(e);
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }
}
