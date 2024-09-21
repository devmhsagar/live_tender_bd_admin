import 'dart:convert';
import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Tender> _tenderList = [];
  List<Tender> _filteredTenderList = [];

  @override
  void initState() {
    super.initState();
    fetchTenderData();
  }

  // Firebase থেকে ডেটা ফেচ করা হচ্ছে
  void fetchTenderData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('tenders').get();
    setState(() {
      _tenderList = snapshot.docs.map((doc) {
        return Tender.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      _filteredTenderList = _tenderList;
    });
  }

  // সার্চ অপশনের জন্য ফাংশন (department ফিল্ড সহ)
  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredTenderList = _tenderList.where((tender) {
          return tender.location.toLowerCase().contains(query.toLowerCase()) ||
              tender.lastDate.toLowerCase().contains(query.toLowerCase()) ||
              tender.method.toLowerCase().contains(query.toLowerCase()) ||
              tender.department
                  .toLowerCase()
                  .contains(query.toLowerCase()); // Added department
        }).toList();
      });
    } else {
      setState(() {
        _filteredTenderList = _tenderList;
      });
    }
  }

  // Excel Export Function
  Future<void> exportToExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Tenders'];
    sheetObject.appendRow([
      'Tender ID',
      'Name of Work',
      'Department',
      'Method',
      'Location',
      'Document Price',
      'Tender Security',
      'Liquid',
      'Similar',
      'Turnover',
      'Tender Capacity',
      'Others',
      'Tender Last Date'
    ]);

    for (Tender tender in _filteredTenderList) {
      sheetObject.appendRow([
        tender.tenderId,
        tender.nameOfWork,
        tender.department,
        tender.method,
        tender.location,
        tender.docPrice,
        tender.tenderSecurity,
        tender.liquid,
        tender.similar,
        tender.turnover,
        tender.tenderCapacity,
        tender.others,
        tender.tenderLastDate
      ]);
    }

    var bytes = excel.encode();
    var content = base64Encode(bytes!);

    final anchor = html.AnchorElement(
        href:
            'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,$content')
      ..setAttribute('download', 'tender_report.xlsx')
      ..click(); // Trigger the download
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report Screen')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            decoration: InputDecoration(
              labelText: 'Search (Location, Method, Department, Date)',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: SfDataGrid(
              source: TenderDataSource(_filteredTenderList),
              columns: [
                GridColumn(columnName: 'tenderId', label: Text('Tender ID')),
                GridColumn(
                    columnName: 'nameOfWork', label: Text('Name of Work')),
                GridColumn(columnName: 'department', label: Text('Department')),
                GridColumn(columnName: 'method', label: Text('Method')),
                GridColumn(columnName: 'location', label: Text('Location')),
                GridColumn(
                    columnName: 'docPrice', label: Text('Document Price')),
                GridColumn(
                    columnName: 'tenderSecurity',
                    label: Text('Tender Security')),
                GridColumn(columnName: 'liquid', label: Text('Liquid')),
                GridColumn(columnName: 'similar', label: Text('Similar')),
                GridColumn(columnName: 'turnover', label: Text('Turnover')),
                GridColumn(
                    columnName: 'tenderCapacity',
                    label: Text('Tender Capacity')),
                GridColumn(columnName: 'others', label: Text('Others')),
                GridColumn(columnName: 'lastDate', label: Text('Last Date')),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: exportToExcel,
                child: Text("Export to Excel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TenderDataSource extends DataGridSource {
  TenderDataSource(List<Tender> tenderList) {
    _dataGridRows = tenderList.map<DataGridRow>((tender) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'tenderId', value: tender.tenderId),
        DataGridCell<String>(
            columnName: 'nameOfWork', value: tender.nameOfWork),
        DataGridCell<String>(
            columnName: 'department', value: tender.department),
        DataGridCell<String>(columnName: 'method', value: tender.method),
        DataGridCell<String>(columnName: 'location', value: tender.location),
        DataGridCell<String>(columnName: 'docPrice', value: tender.docPrice),
        DataGridCell<String>(
            columnName: 'tenderSecurity', value: tender.tenderSecurity),
        DataGridCell<String>(columnName: 'liquid', value: tender.liquid),
        DataGridCell<String>(columnName: 'similar', value: tender.similar),
        DataGridCell<String>(columnName: 'turnover', value: tender.turnover),
        DataGridCell<String>(
            columnName: 'tenderCapacity', value: tender.tenderCapacity),
        DataGridCell<String>(columnName: 'others', value: tender.others),
        DataGridCell<String>(columnName: 'lastDate', value: tender.lastDate),
      ]);
    }).toList();
  }

  List<DataGridRow> _dataGridRows = [];

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child:
              Text(dataGridCell.value.toString(), softWrap: true, maxLines: 2),
        );
      }).toList(),
    );
  }
}
