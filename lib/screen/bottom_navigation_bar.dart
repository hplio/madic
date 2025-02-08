import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/utils/color.dart';

import '../controller/bottom_navigation_controller.dart';
import 'add_madicine_screen.dart';

class BottomNavigationBarMadic extends StatelessWidget {
  const BottomNavigationBarMadic({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavigationController controller =
        Get.put(BottomNavigationController());
    return Scaffold(
      body: Obx(() => controller.page[controller.index.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: ()=>Get.to(()=>const AddMedicineScreen()),
        backgroundColor: celanderColor,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 0,
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(color: primaryColor),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart), label: 'Report'),
          ],
          currentIndex: controller.index.value,
          onTap: (index) => controller.index.value = index,
        ),
      ),
    );
  }
}
