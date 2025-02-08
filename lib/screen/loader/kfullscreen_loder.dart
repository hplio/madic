import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:madic/utils/color.dart';

class KfullscreenLoder {
  static void openLodingDialog(String title) {
    showDialog(
      barrierDismissible: false,
      context: Get.overlayContext!,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(Get.context!).size.height,
          width: MediaQuery.of(Get.context!).size.width,
          child: Center(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, 
              mainAxisAlignment:
                  MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoadingAnimationWidget.inkDrop(
                  color: primaryColor,
                  size: 35,
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  title,
                  style: Theme.of(Get.context!).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
