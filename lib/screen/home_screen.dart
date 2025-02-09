import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:madic/screen/settings_screen.dart';
import 'package:madic/screen/widget/madical_info_widget.dart';
import 'package:madic/utils/color.dart';
import '../auth/user/madical_data.dart';
import '../auth/user/user_repo.dart';
import '../common/date_builder_widget.dart';
import '../controller/calender_controller.dart';
import '../controller/notification_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(FirestoreService());
    final controller = Get.put(CalendarController());
    Get.put(NotificationController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                          "Hi ${userController.user.value?.name ?? 'Harry'}!",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    const Text("5 Medicines Left",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.medical_services, color: Colors.blue),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => Get.to(() => const SettingsScreen()),
                          child: CircleAvatar(
                            backgroundImage:
                                Image.asset('assets/image/person_icon.png')
                                    .image,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DateBuilderWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  StreamBuilder<List<MedicalRecord>>(
                    stream: controller.getMedicalRecordsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                            child: Text("Error loading records"));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text("No medical records found"));
                      }

                      return Obx(() {
                        List<MedicalRecord> filteredRecords =
                            controller.filterRecordsByDate(snapshot.data!);
                        if (filteredRecords.isEmpty) {
                          return const Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'No Madical Data found is this date.',
                                ),
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredRecords.length,
                          itemBuilder: (_, int index) {
                            var record = filteredRecords[index];
                            String formattedDate =
                                DateFormat('MMM, d').format(record.startDate);

                            return GestureDetector(
                              onTap: () async =>
                                  await controller.giveSchaduleToNotification(),
                              child: MadicalInfoWidget(
                                whenPillTack: record.whenPillTake,
                                containerColor: record.pillColor,
                                bellColor: lightRedColor,
                                title: formattedDate,
                              ),
                            );
                          },
                        );
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
