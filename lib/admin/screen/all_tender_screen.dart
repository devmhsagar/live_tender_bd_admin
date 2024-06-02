import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:live_tender_bd_admin/admin/service/database.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';


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

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text('Tender ID')),
                DataColumn(label: Text('Name of Work')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Method')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Last Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: tenders.map((tender) {
                return DataRow(cells: [
                  DataCell(Text(tender.tenderId)),
                  DataCell(Text(tender.nameOfWork)),
                  DataCell(Text(tender.department)),
                  DataCell(Text(tender.method)),
                  DataCell(Text(tender.location)),
                  DataCell(Text(tender.lastDate)),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Implement edit functionality
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Implement delete functionality
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          // Implement view functionality
                        },
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
