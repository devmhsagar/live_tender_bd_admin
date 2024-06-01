import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  // Method to add tender details to Firestore
  Future<void> addTender(Map<String, dynamic> addTenderMap, String id) async {
    try {
      await _firestore.collection("tenders").doc(id).set(addTenderMap);
    } catch (e) {
      print('Error adding tender: $e');
    }
  }

  // Method to generate a unique ID
  String generateUniqueId() {
    return _uuid.v4();
  }

  // Method to check if a tender ID already exists
  Future<bool> tenderIdExists(String tenderId) async {
    try {
      final querySnapshot = await _firestore
          .collection("tenders")
          .where('tenderId', isEqualTo: tenderId)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking tender ID: $e');
      return false;
    }
  }
}
