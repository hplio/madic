import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/controller/notification_controller.dart';
import '../auth/user/madical_data.dart';
import '../auth/user/user_repo.dart';
import '../screen/loader/snack_bar.dart';

class CalendarController extends GetxController {
  var dates = <DateTime>[].obs;
  // var selectedDate = DateTime.now().obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  var tasks = <String>[].obs;
  RxList<MedicalRecord> records = <MedicalRecord>[].obs;
  final userRepo = Get.put(FirestoreService());
  DateTime? selectedNotificationDate;
  TimeOfDay? selectedNotificationTime;
  @override
  void onInit() {
    super.onInit();
    generateDates();
  }

  Future<void> giveSchaduleToNotification() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    selectedNotificationDate = pickedDate;
    selectedNotificationTime = pickedTime;
    if (selectedNotificationDate == null || selectedNotificationTime == null) {
      showErrorSnackbar(
        title: 'Ohh snap!!',
        message: 'You have to select date and time for notification.',
      );
      return;
    }

    DateTime scheduledTime = DateTime(
      selectedNotificationDate!.year,
      selectedNotificationDate!.month,
      selectedNotificationDate!.day,
      selectedNotificationTime!.hour,
      selectedNotificationTime!.minute,
    );

    final notificationController = NotificationController.instance;

    notificationController.scheduleNotification(
      scheduledTime,
    );
    showSuccessSnackbar(
      title: 'Success',
      message: 'Your notification is schedule successfully.',
    );
  }

  Stream<List<MedicalRecord>> getMedicalRecordsStream() {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    return db
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('medicalRecords')
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MedicalRecord.fromMap(doc.data(), doc.id))
            .toList());
  }

  void generateDates() {
    DateTime today = DateTime.now();
    dates.clear();
    for (int i = -10; i <= 10; i++) {
      dates.add(today.add(Duration(days: i)));
    }
  }

  /// Filter records based on selected date
  List<MedicalRecord> filterRecordsByDate(List<MedicalRecord> allRecords) {
    if (selectedDate.value == null) {
      return allRecords;
    }
    return allRecords.where((record) {
      return record.startDate.day == selectedDate.value!.day &&
          record.startDate.month == selectedDate.value!.month &&
          record.startDate.year == selectedDate.value!.year;
    }).toList();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    selectedDate.refresh();
  }
}
