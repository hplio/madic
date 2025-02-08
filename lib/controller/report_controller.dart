import 'package:get/get.dart';

class ReportController extends GetxController {
  var selectedDay = 1.obs;

  final days= [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ].obs;
}