import 'package:madic/auth/user/madical_data.dart';

class UserModel {
  String? id;
  String name;
  String email;
  List<MedicalRecord>? medicalRecords;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.medicalRecords,
  });

  // Convert from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
