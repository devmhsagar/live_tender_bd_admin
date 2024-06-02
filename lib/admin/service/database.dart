import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  Future<void> addTender(Tender tender) async {
    try {
      await _firestore.collection("tenders").doc(tender.id).set(tender.toMap());
    } catch (e) {
      print('Error adding tender: $e');
    }
  }

  String generateUniqueId() {
    return _uuid.v4();
  }

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
