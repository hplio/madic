import 'package:get/get.dart';

import '../controller/network_controller.dart'; // Import the NetworkController

class NetworkBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
  }
}
