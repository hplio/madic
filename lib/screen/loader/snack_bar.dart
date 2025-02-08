import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:madic/utils/color.dart';

void showErrorSnackbar({required String title, required String message}) {
  Get.snackbar(
    title, // Title
    message, // Message
    snackPosition: SnackPosition.BOTTOM, // Position
    margin: const EdgeInsets.all(12),
    backgroundColor: Colors.red, // Background color
    colorText: Colors.white, // Text color
    icon: const Icon(Icons.error, color: Colors.white), // Error icon
    duration: const Duration(seconds: 3), // Display duration
  );
}

void showSuccessSnackbar({required String title, required String message}) {
  Get.snackbar(
    title, // Title
    margin: const EdgeInsets.all(12),
    message, // Message
    snackPosition: SnackPosition.BOTTOM, // Position
    backgroundColor: primaryColor, // Background color
    colorText: Colors.white, // Text color
    icon: const Icon(Icons.check, color: Colors.white), // Error icon
    duration: const Duration(seconds: 3), // Display duration
  );
}
