import 'package:flutter/material.dart';

class MedicalRecord {
  String id;
  String totalCount;
  DateTime startDate;
  DateTime endDate;
  String howManyDays;
  String frequency;
  String whenPillTake;
  Color? pillColor;

  MedicalRecord({
    required this.id,
    required this.frequency,
    required this.totalCount,
    required this.startDate,
    required this.endDate,
    required this.howManyDays,
    required this.whenPillTake,
    this.pillColor,
  });

  // Convert Color to Hex String (for Firestore)
  String? _colorToHex(Color? color) {
    if (color == null) return null;
    return color.value.toRadixString(16); // Convert to hex
  }

  // Convert Hex String to Color (when fetching from Firestore)
  // Color? _hexToColor(String? hexColor) {
  //   if (hexColor == null) return null;
  //   return Color(int.parse(hexColor, radix: 16));
  // }

  // Convert Object to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'totalCount': totalCount,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
      'frequency': frequency,
      'howManyDays': howManyDays,
      'whenPillTake': whenPillTake,
      'pillColor': _colorToHex(pillColor), // Store color as hex string
    };
  }

  // Convert Firestore Map to Object
  factory MedicalRecord.fromMap(Map<String, dynamic> map, String docId) {
    return MedicalRecord(
      frequency: map['frequency'],
      id: docId,
      totalCount: map['totalCount'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      howManyDays: map['howManyDays'],
      whenPillTake: map['whenPillTake'],
      pillColor: map['pillColor'] != null
          ? Color(int.parse(map['pillColor'], radix: 16))
          : null,
    );
  }
}
