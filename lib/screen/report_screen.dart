import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/screen/widget/days_container.dart';
import 'package:madic/screen/widget/madical_card.dart';
import 'package:madic/screen/widget/madical_info_widget.dart';
import 'package:madic/utils/color.dart';

import '../controller/report_controller.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportController controller = Get.put(ReportController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Report',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportSummary(),
            const SizedBox(height: 16),
            _buildDashboardCard(),
            const SizedBox(height: 16),
            _buildCheckHistory(),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) => Column(
                  children: [
                    Text(
                      controller.days[index],
                      style: const TextStyle(
                        color: Colors.black26,
                      ),
                    ),
                    Obx(
                      () => DaysContainer(
                        title: (index + 1).toString(),
                        onTap: () => controller.selectedDay.value = index + 1,
                        backgroundColor:
                            controller.selectedDay.value == index + 1
                                ? primaryColor
                                : ragularColor,
                        titleColor: controller.selectedDay.value == index + 1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: controller.days.length,
              ),
            ),
            const SizedBox(height: 16),
            const MadicalInfoWidget(
              whenPillTack: 'Before BreakFast',
              title: 'Morning 08:00 AM',
              containerColor: lightPurpleColor,
              bellColor: Colors.green,
              children: [
                MadicalCard(
                  containerColor: lightPinkisColor,
                  bellColor: Colors.red,
                  whenPillTack: 'Before BreakFast',
                  subTitle: 'Missed',
                ),
              ],
            ),
            const SizedBox(height: 16),
            const MadicalInfoWidget(
              whenPillTack: 'Before BreakFast',
              title: 'Afternoon 02:00 PM',
              containerColor: lightPurpleColor,
              bellColor: lightRedColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's Report",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildReportItem('5', 'Total'),
              _buildReportItem('3', 'Taken'),
              _buildReportItem('1', 'Missed'),
              _buildReportItem('1', 'Snoozed'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDashboardCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Check Dashboard",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              SizedBox(
                width: 200,
                child: Text(
                    softWrap: true,
                    "Here you will find everything related to your activity and past medicines.",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ],
          ),
          Icon(Icons.pie_chart, color: Colors.blue, size: 70),
        ],
      ),
    );
  }

  Widget _buildCheckHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Check History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
