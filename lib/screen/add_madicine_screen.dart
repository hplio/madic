import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:madic/utils/color.dart';
import 'package:madic/utils/common_data.dart';

import '../common/title_icon_widget.dart';
import '../controller/madicine_controller.dart';
import 'widget/row_icon_widget.dart';
import 'widget/select_widget_Container.dart';

class AddMedicineScreen extends StatelessWidget {
  const AddMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MedicineController controller = Get.put(MedicineController());
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text("Add Medicines")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: "Search Medicine Name",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.mic,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Compartment",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Obx(() => Row(
                    children: List.generate(6, (index) {
                      return GestureDetector(
                        onTap: () =>
                            controller.selectedCompartment.value = index + 1,
                        child: Container(
                          height: 60,
                          width: 50,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: controller.selectedCompartment.value ==
                                    index + 1
                                ? compartmentColor
                                : Colors.grey[200],
                            border: Border.all(
                              color: controller.selectedCompartment.value ==
                                      index + 1
                                  ? primaryColor
                                  : compartmentBorderColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                              child: Text(
                            "${index + 1}",
                            style: const TextStyle(fontSize: 16),
                          )),
                        ),
                      );
                    }),
                  )),
              const SizedBox(height: 16),
              const Text(
                "Colour",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.colors.length,
                  itemBuilder: (context, index) {
                    final color = controller.colors[index];
                    return Obx(
                      () => GestureDetector(
                        onTap: () => controller.selectedColor.value = color,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: controller.selectedColor.value == color
                                  ? primaryColor
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Type",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 36),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.types.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Image(
                          height: 50,
                          image: AssetImage(controller.types[index]),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          controller.typesName[index],
                          style: TextStyle(color: Colors.black.withOpacity(.8)),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Quantity",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Text("Take 1/2 Pill")),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: primaryColor),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => controller.quantity.value =
                          (controller.quantity.value > 1)
                              ? controller.quantity.value - 1
                              : 1,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: primaryColor),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (controller.quantity.value < 100) {
                          controller.quantity.value++;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Count",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey),
                      color: const Color(0xffFAFAFA),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(() => Text("${controller.quantity.value}")),
                    ),
                  ),
                ],
              ),
              Obx(
                () => Slider(
                  activeColor: primaryColor,
                  min: 1,
                  max: 100,
                  value: controller.quantity.value.toDouble(),
                  onChanged: (value) =>
                      controller.quantity.value = value.toInt(),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1'),
                  Text('100'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Set Date",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller.startDate.value,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) controller.startDate.value = picked;
                      },
                      child: Obx(
                        () => TitleIconContainer(
                            title: controller.startDate.value == null
                                ? 'Today'
                                : "${controller.startDate.value?.toLocal()}"
                                    .split(' ')[0]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: controller.endDate.value,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) controller.endDate.value = picked;
                      },
                      child: Obx(
                        () => TitleIconContainer(
                            title: controller.endDate.value == null
                                ? 'End Date'
                                : "${controller.endDate.value?.toLocal()}"
                                    .split(' ')[0]),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Frequency of Days",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton2(
                    iconStyleData: dropDownIconStyleData,
                    isExpanded: true,
                    value: controller.frequency.value,
                    onChanged: (value) => controller.frequency.value = value!,
                    items: ["Everyday", "Every 2 Days", "Every 3 Days"]
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    buttonStyleData: dropDownbuttonStyleData,
                    dropdownStyleData: dropdownStyleData,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "How many times a day",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton2(
                    iconStyleData: dropDownIconStyleData,
                    isExpanded: true,
                    value: controller.timesPerDay.value,
                    onChanged: (value) => controller.timesPerDay.value = value!,
                    items: ["One Time", "Two Time", "Three Time"]
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    buttonStyleData: dropDownbuttonStyleData,
                    dropdownStyleData: dropdownStyleData,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const RowIconWiget(
                title: 'Dose 1',
              ),
              const Divider(color: Colors.grey),
              const RowIconWiget(
                title: 'Dose 2',
              ),
              const Divider(color: Colors.grey),
              const RowIconWiget(
                title: 'Dose 3',
              ),
              const Divider(color: Colors.grey),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.selectMadicineList.length,
                  itemBuilder: (_, int index) => Obx(
                    () => SletectWidgetContainr(
                      onTap: () => controller.selectMadicine.value =
                          controller.selectMadicineList[index],
                      isSelected: controller.selectMadicine.value ==
                          controller.selectMadicineList[index],
                      title: controller.selectMadicineList[index],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () async => await controller.addMadicinesData(),
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
