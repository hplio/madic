import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/auth/user/user_model.dart';
import 'package:madic/auth/user/user_repo.dart';
import 'package:madic/controller/network_controller.dart';
import '../auth/repositoeies_authentication.dart';
import '../screen/bottom_navigation_bar.dart';
import '../screen/loader/kfullscreen_loder.dart';
import '../screen/loader/snack_bar.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  final authRepoController = Get.put(AuthenticationRepo());
  final userController = Get.put(FirestoreService());

  Future<void> login() async {
    KfullscreenLoder.openLodingDialog('Sign In..');
    try {
      final isConnected = NetworkController.instance.isConnected.value;
      if (!isConnected) {
        KfullscreenLoder.stopLoading();
        return;
      }
      if (!signInKey.currentState!.validate()) {
        KfullscreenLoder.stopLoading();
        return;
      }

      await authRepoController.loginWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      await userController.fetchUserData();

      KfullscreenLoder.stopLoading();
      Get.offAll(() => const BottomNavigationBarMadic());
    } catch (e) {
      KfullscreenLoder.stopLoading();
     showErrorSnackbar(
        title: 'Ohh snap!!',
        message: e.toString(),
      );
      return;
    }
  }

  Future<void> googleSignIn() async {
    try {
      KfullscreenLoder.openLodingDialog('LogIn you in...');

      final isConnected = NetworkController.instance.isConnected.value;
      if (!isConnected) {
        KfullscreenLoder.stopLoading();
        return;
      }

      final userCredential = await authRepoController.signInWithGoogle();
      User? user = userCredential.user;

      if (user != null) {
        UserModel newUser = UserModel(
          name: user.displayName ?? '',
          email: user.email ?? '',
          id: user.uid,
        );

        await userController.saveUser(newUser);
        userController.user.value = newUser;
        KfullscreenLoder.stopLoading();
        Get.offAll(() => const BottomNavigationBarMadic());
        return;
      }

      KfullscreenLoder.stopLoading();
      return;
    } catch (e) {
      KfullscreenLoder.stopLoading();
      showErrorSnackbar(
        title: 'Ohh snap!!',
        message: e.toString(),
      );
      return;
    }
  }
}
