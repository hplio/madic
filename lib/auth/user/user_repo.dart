import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:madic/auth/user/madical_data.dart';
import '../repositoeies_authentication.dart';
import 'user_model.dart';

class FirestoreService extends GetxController{
  final FirebaseFirestore _db = FirebaseFirestore.instance;
   final authController = Get.put(AuthenticationRepo());
     Rx<UserModel?> user = Rx<UserModel?>(null);
     final _auth = FirebaseAuth.instance;

  /// Fetch user after login
  Future<void> fetchUserData() async {
    User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      UserModel? fetchedUser = await getUser();
      if (fetchedUser != null) {
        user.value = fetchedUser;
      }
    }
  }

  /// Save user to Firestore
  Future<void> saveUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  /// Fetch user data
  Future<UserModel?> getUser() async {
    DocumentSnapshot doc = await _db.collection('users').doc(_auth.currentUser?.uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  /// Save medical record under user's medicalRecords subcollection
  Future<void> addMedicalRecord( MedicalRecord record) async {
    await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        // .doc(userId)
        .collection('medicalRecords')
        .doc(record.id)
        .set(record.toMap());
  }

  /// Fetch medical records by user and time (sorted by date)
  Future<List<MedicalRecord>> getMedicalRecords() async {
    QuerySnapshot snapshot = await _db
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .collection('medicalRecords')
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs
        .map((doc) =>
            MedicalRecord.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

}
