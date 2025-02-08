import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/screen/home_screen.dart';
import 'package:madic/screen/report_screen.dart';

class BottomNavigationController extends GetxController {
  
  final index= 0.obs;

  final page=<Widget>[
    const HomeScreen(),
    const ReportScreen(),
  ].obs;

}