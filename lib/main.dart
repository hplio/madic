import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/firebase_options.dart';
import 'package:madic/screen/login_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'bindings/network_binding.dart';
import 'controller/notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  tz.initializeTimeZones();
  Get.put(NotificationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: NetworkBinding(),
      debugShowCheckedModeBanner: false,
      home: const SignInScreen(),
    );
  }
}
