import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/service/database.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';
import 'package:live_tender_bd_admin/admin/widget/narrow_layout_all_tender.dart';
import 'package:live_tender_bd_admin/admin/widget/wide_layout_all_tender.dart';

class AllTenderPage extends StatelessWidget {
  final DatabaseMethods _databaseMethods = DatabaseMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tender List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tenders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<Tender> tenders = snapshot.data!.docs.map((doc) {
            return Tender.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return WideLayout(tenders: tenders);
              } else {
                return NarrowLayout(tenders: tenders);
              }
            },
          );
        },
      ),
    );
  }
}
