import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/controller/login_controller.dart';
import 'package:madic/controller/sign_up_controller.dart';
import 'package:madic/utils/color.dart';
import 'package:madic/utils/common_data.dart';
import 'package:madic/utils/validator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: controller.signUpKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),
                    const Center(
                      child: Column(
                        children: [
                          Icon(Icons.medical_services,
                              size: 60, color: primaryColor),
                          Text(
                            "Adhicine",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text("Sign Up",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.email,
                      validator: (value) => Kvalidator.validateEmail(value),
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: iconColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Obx(
                      () => TextFormField(
                        controller: controller.password,
                        validator: (value) =>
                            Kvalidator.validatePassword(value),
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: iconColor,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () => controller.isPasswordVisible
                                .value = !controller.isPasswordVisible.value,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Forgot Password?",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async => await controller.signUp(),
                        style: elevatedButtonStyle,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("OR"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async =>
                            await loginController.googleSignIn(),
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            side: const BorderSide(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icon/image.png", height: 24),
                            const SizedBox(width: 10),
                            const Text("Continue with Google",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
