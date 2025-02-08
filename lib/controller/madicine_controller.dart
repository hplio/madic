import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/auth/user/user_repo.dart';
import 'package:madic/controller/network_controller.dart';
import 'package:madic/screen/bottom_navigation_bar.dart';
import 'package:madic/screen/loader/kfullscreen_loder.dart';
import 'package:madic/screen/loader/snack_bar.dart';
import '../auth/user/madical_data.dart';

class MedicineController extends GetxController {
  var selectedCompartment = 1.obs;
  var selectedColor = const Color(0xfff9ceee).obs;
  var selectedType = "Tablet".obs;
  var quantity = 1.obs;
  // var totalCount = 1.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var frequency = "Everyday".obs;
  var timesPerDay = "Three Time".obs;

  var selectMadicine = 'Before Food'.obs;

  final selectMadicineList = [
    'Before Food',
    'After Food',
    'Before Sleep',
  ].obs;

  List<Color> colors = [
    const Color(0xfff9ceee),
    const Color(0xffc1b6ff),
    const Color(0xffFF9696),
    const Color(0xffCEFBBE),
    const Color(0xffF9C290),
    const Color(0xffBAE6FF),
    const Color(0xffFFFAB2),
  ];

  List<String> types = [
    'assets/image/medicine-tablet-48.png',
    'assets/image/pill.png',
    'assets/image/antiseptic-cream.png',
    'assets/image/pharma.png'
  ];
  List<String> typesName = [
    'Tablet',
    'Capsule',
    'Cream',
    'Liquid',
  ];

  final userController = Get.put(FirestoreService());

  Future<void> addMadicinesData() async {
    KfullscreenLoder.openLodingDialog('Processing...');
    try {
      final isConnected = NetworkController.instance.isConnected.value;
      if (!isConnected) {
        KfullscreenLoder.stopLoading();
        return;
      }
      if (startDate.value == null || endDate.value == null) {
        KfullscreenLoder.stopLoading();
        showErrorSnackbar(
          title: 'Ohh snap!!',
          message: 'Date is required.',
        );
        return;
      }
      String randomId =
          FirebaseFirestore.instance.collection('medicalRecords').doc().id;
      final MedicalRecord newRecord = MedicalRecord(
        id: randomId,
        totalCount: quantity.value.toString(),
        startDate: startDate.value!,
        endDate: endDate.value!,
        howManyDays: timesPerDay.value,
        frequency: frequency.value,
        whenPillTake: selectMadicine.value,
        pillColor: selectedColor.value,
      );
      await userController.addMedicalRecord(newRecord);
      KfullscreenLoder.stopLoading();
      showSuccessSnackbar(
        title: 'Success',
        message: 'Medicine data added.',
      );
      Get.offAll(() => const BottomNavigationBarMadic());
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
