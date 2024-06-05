import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';

class WideLayout extends StatelessWidget {
  final List<Tender> tenders;
  final Function(String) onDelete;

  WideLayout({required this.tenders, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: const [
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
                  width: 200,
                  child: Text(
                    tender.nameOfWork,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Text(
                    tender.department,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(Text(tender.method)),
              DataCell(Text(tender.location)),
              DataCell(Text(tender.lastDate)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Implement edit functionality
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      onDelete(tender.tenderId);
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
      ),
    );
  }
}
