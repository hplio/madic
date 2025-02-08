import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/auth/repositoeies_authentication.dart';
import 'package:madic/auth/user/user_model.dart';
import 'package:madic/controller/network_controller.dart';
import 'package:madic/screen/bottom_navigation_bar.dart';
import 'package:madic/screen/loader/kfullscreen_loder.dart';
import '../auth/user/user_repo.dart';
import '../screen/loader/snack_bar.dart';

class SignUpController extends GetxController {
  var isPasswordVisible = false.obs;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  final authRepoController = Get.put(AuthenticationRepo());

  Future<void> signUp() async {
    KfullscreenLoder.openLodingDialog('Sign Up..');

    try {
      final isConnected = NetworkController.instance.isConnected.value;
      if (!isConnected) {
        KfullscreenLoder.stopLoading();
        return;
      }
      if (!signUpKey.currentState!.validate()) {
        KfullscreenLoder.stopLoading();
        return;
      }

      final userCredentia =
          await authRepoController.registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      final newUser = UserModel(
        name: '',
        email: email.text.trim(),
        id: userCredentia.user?.uid,
      );

      final userRepo = Get.put(FirestoreService());
      await userRepo.saveUser(newUser);

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
}
