import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:madic/utils/color.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controller/calender_controller.dart';

class DateBuilderWidget extends StatelessWidget {
  const DateBuilderWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());
    final ItemScrollController scrollController = ItemScrollController();
    return Obx(
      () => SizedBox(
        height: 60,
        child: ScrollablePositionedList.builder(
          itemScrollController: scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: controller.dates.length,
          itemBuilder: (context, index) {
            var date = controller.dates[index];
            return Obx(
              () => GestureDetector(
                onTap: () {
                  controller.updateSelectedDate(date);
                  scrollController.scrollTo(
                    index: index,
                    duration: const Duration(milliseconds: 300),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: controller.selectedDate.value == date
                        ? primaryColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E')
                            .format(date), 
                        style: TextStyle(
                          color: controller.selectedDate.value == date
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      Text(
                        DateFormat('d').format(date), 
                        style: TextStyle(
                            color: controller.selectedDate.value == date
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
