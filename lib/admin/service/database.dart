import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();

  Future<void> addTender(Map<String, dynamic> addTenderMap, String id) async {
    return await _firestore.collection("tenders").doc(id).set(addTenderMap);
  }

  String generateUniqueId() {
    return _uuid.v4();
  }

  Future<bool> tenderIdExists(String tenderId) async {
    final querySnapshot = await _firestore
        .collection("tenders")
        .where('tenderId', isEqualTo: tenderId)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }
}
