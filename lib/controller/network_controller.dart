import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  static NetworkController get instance => Get.find();
  final Connectivity _connectivity = Connectivity();

  // Observable variable to track connectivity status
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnectivity();
    _listenToConnectivityChanges();
  }

  // Check initial connectivity status
  void _checkInitialConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  // Listen to connectivity changes
  void _listenToConnectivityChanges() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Update connection status based on connectivity result
  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      isConnected.value = false;
      _showNoInternetDialog(); // Show custom dialog when connection is lost
    } else {
      isConnected.value = true;
      if (Get.isDialogOpen ?? false) {
        Get.back(); // Close the dialog if the connection is restored
      }
    }
  }

  void _showNoInternetDialog() {
    Get.defaultDialog(
      title: 'Your Device is not connected',
      middleText: 'Connect your device with the internet to continue.',
      textConfirm: 'OK',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
      barrierDismissible: false,
    );
  }
}
