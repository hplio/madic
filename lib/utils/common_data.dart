import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:madic/utils/color.dart';

ButtonStyleData? dropDownbuttonStyleData = ButtonStyleData(
  padding: const EdgeInsets.only(left: 14, right: 14),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    border: Border.all(
      color: Colors.black26,
    ),
  ),
);

DropdownStyleData dropdownStyleData = DropdownStyleData(
  maxHeight: 200,
  width: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    color: Colors.white,
  ),
);

IconStyleData dropDownIconStyleData = const IconStyleData(
  icon: Icon(
    Icons.keyboard_arrow_down,
    size: 30,
  ),
  iconSize: 30,
  iconEnabledColor: Colors.grey,
  iconDisabledColor: Colors.grey,
);

ButtonStyle? elevatedButtonStyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(vertical: 15),
  backgroundColor: const Color(0xff6f8bef),
);

Decoration? commonDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  color: ragularColor,
);

TextStyle? moreSettingstyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
