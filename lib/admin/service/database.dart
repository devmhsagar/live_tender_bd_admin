import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addTender(Map<String, dynamic> addTenderMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("tenders")
        .doc(id)
        .set(addTenderMap);
  }
}
