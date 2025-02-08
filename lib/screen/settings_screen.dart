import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/auth/repositoeies_authentication.dart';
import 'package:madic/controller/notification_controller.dart';
import 'package:madic/utils/color.dart';
import 'package:madic/utils/common_data.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.put(SettingsController());
    final notificationController = NotificationController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/image/person_icon.png'),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Take Care!", style: TextStyle(fontSize: 14)),
                        Text("Richa Bose",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Divider(
                  color: Colors.grey.withOpacity(.6),
                ),
                const SizedBox(height: 10),
                const Text("Settings",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    DateTime scheduledTime =
                        DateTime.now().add(const Duration(seconds: 1));
                    notificationController.scheduleNotification(scheduledTime);
                  },
                  child: settingTile(
                    Icons.notifications,
                    "Notification",
                    "Check your medicine notification",
                  ),
                ),
                settingTile(
                  Icons.volume_up,
                  "Sound",
                  "Ring, Silent, Vibrate",
                ),
                settingTile(
                  Icons.person,
                  "Manage Your Account",
                  "Password, Email ID, Phone Number",
                ),
                const SizedBox(height: 20),
                const Text("Device",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                deviceCard(),
                const SizedBox(height: 20),
                const Text(
                  "Caretakers: 03",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: commonDecoration,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 12,
                      bottom: 12,
                      right: 12,
                    ),
                    child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, int index) => ImageNameWidget(
                          isAdd: controller.caretakersList[index] == 'Add',
                          name: controller.caretakersList[index],
                        ),
                        separatorBuilder: (_, __) => const SizedBox(
                          width: 24,
                        ),
                        itemCount: controller.caretakersList.length,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                const Text(
                  "Doctor",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: commonDecoration,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: primaryColor,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Textspam(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  "Privacy Policy",
                  style: moreSettingstyle,
                ),
                const SizedBox(height: 28),
                Text(
                  "Terms of Use",
                  style: moreSettingstyle,
                ),
                const SizedBox(height: 28),
                Text(
                  "Rate Us",
                  style: moreSettingstyle,
                ),
                const SizedBox(height: 28),
                Text(
                  "Share",
                  style: moreSettingstyle,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () async =>
                        await AuthenticationRepo.instance.logOut(),
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget settingTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
    );
  }

  Widget deviceCard() {
    final SettingsController controller = Get.put(SettingsController());
    return Card(
      elevation: 0,
      color: ragularColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => ListTile(
                onTap: () => controller.selectedIndex.value = 0,
                tileColor:
                    controller.selectedIndex.value == 0 ? Colors.white : null,
                leading: const Icon(Icons.bluetooth, color: Colors.grey),
                title: const Text("Connect"),
                subtitle: const Text("Bluetooth, Wi-Fi"),
              ),
            ),
            Obx(
              () => ListTile(
                onTap: () => controller.selectedIndex.value = 1,
                tileColor:
                    controller.selectedIndex.value == 1 ? Colors.white : null,
                leading: const Icon(Icons.volume_up, color: Colors.grey),
                title: const Text("Sound Option"),
                subtitle: const Text("Ring, Silent, Vibrate"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget caretakersSection() {
  //   final SettingsController controller = Get.put(SettingsController());
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text("Caretakers: 03",
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       const SizedBox(height: 10),
  //       Card(
  //         elevation: 0,
  //         color: ragularColor,
  //         child: Row(
  //           children: [
  //             ImageNameWidget(name: controller.caretakersList[0],),
  //             const SizedBox(width: 10),
  //             ImageNameWidget(name: controller.caretakersList[1],),
  //             const SizedBox(width: 10),
  //             ImageNameWidget(name: controller.caretakersList[2],),
  //             const SizedBox(width: 10),
  //             // ImageNameWidget(controller: controller),
  //             // const SizedBox(width: 10),
  //             // const CircleAvatar(
  //             //     backgroundImage: AssetImage('assets/image/person_icon.png')),
  //             // const SizedBox(width: 10),
  //             // const CircleAvatar(
  //             //     backgroundImage: AssetImage('assets/image/person_icon.png')),
  //             // const SizedBox(width: 10),
  //             CircleAvatar(
  //                 backgroundColor: Colors.grey.shade300,
  //                 child: const Icon(Icons.add)),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget doctorSection() {
  //   return Card(
  //     color: Colors.blue.shade50,
  //     child: const ListTile(
  //       leading: Icon(Icons.add, color: Colors.blue),
  //       title: Text("Add Your Doctor"),
  //       subtitle:
  //           Text("Or use invite link", style: TextStyle(color: Colors.orange)),
  //     ),
  //   );
  // }
}

class Textspam extends StatelessWidget {
  const Textspam({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        children: [
          TextSpan(text: 'Add Your Doctor \n', style: TextStyle(fontSize: 16)),
          TextSpan(text: 'Or use'),
          TextSpan(
            text: ' invite link',
            style: TextStyle(
              color: lightRedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageNameWidget extends StatelessWidget {
  const ImageNameWidget({
    super.key,
    required this.name,
    required this.isAdd,
  });

  final String name;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: isAdd ? Colors.white : null,
          backgroundImage:
              isAdd ? null : const AssetImage('assets/image/person_icon.png'),
          child: isAdd
              ? const Icon(
                  Icons.add,
                  color: Colors.grey,
                )
              : null,
        ),
        Text(
          softWrap: true,
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
