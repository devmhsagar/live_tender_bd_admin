import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';

class WideLayout extends StatelessWidget {
  final List<Tender> tenders;

  WideLayout({required this.tenders});

  @override
  Widget build(BuildContext context) {
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
            DataCell(
              SizedBox(
                width: 200, // Set a fixed width for the column
                child: Text(
                  tender.nameOfWork,
                  maxLines: 1, // Limit the number of lines
                  overflow: TextOverflow.ellipsis, // Add ellipsis
                ),
              ),
            ),
            DataCell(
              SizedBox(
                width: 100, // Set a fixed width for the column
                child: Text(
                  tender.department,
                  maxLines: 1, // Limit the number of lines
                  overflow: TextOverflow.ellipsis, // Add ellipsis
                ),
              ),
            ),
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
  }
}
