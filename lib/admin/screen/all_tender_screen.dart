import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/service/database.dart';
import 'package:live_tender_bd_admin/admin/service/tender_view_model.dart';
import 'package:live_tender_bd_admin/admin/widget/narrow_layout_all_tender.dart';
import 'package:live_tender_bd_admin/admin/widget/wide_layout_all_tender.dart';

class AllTenderPage extends StatefulWidget {
  @override
  _AllTenderPageState createState() => _AllTenderPageState();
}

class _AllTenderPageState extends State<AllTenderPage> {
  final DatabaseMethods _databaseMethods = DatabaseMethods();
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _filter = 'All Tender';
  late List<Tender> _tenders = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _deleteTender(String tenderId) async {
    try {
      // Optimistically update UI
      setState(() {
        _tenders.removeWhere((tender) => tender.tenderId == tenderId);
      });

      await _databaseMethods.deleteTender(tenderId);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tender deleted successfully')),
      );
    } catch (e) {
      // Revert UI changes if deletion fails
      setState(() {
        // Refetch data or restore the previous state
      });

      print('Error deleting tender: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete tender')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tender List'),
        actions: [
          Container(
            width: 200,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                icon: Icon(Icons.search),
              ),
            ),
          ),
          DropdownButton<String>(
            value: _filter,
            onChanged: (String? newValue) {
              setState(() {
                _filter = newValue!;
              });
            },
            items: <String>['All Tender', 'Oldest Tender', 'Newest Tender']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tenders').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          _tenders = snapshot.data!.docs.map((doc) {
            return Tender.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          // Apply search filter
          if (_searchQuery.isNotEmpty) {
            _tenders = _tenders.where((tender) {
              return tender.tenderId.contains(_searchQuery) ||
                  tender.nameOfWork.contains(_searchQuery) ||
                  tender.department.contains(_searchQuery) ||
                  tender.method.contains(_searchQuery) ||
                  tender.location.contains(_searchQuery) ||
                  tender.lastDate.contains(_searchQuery);
            }).toList();
          }

          // Apply date filter
          if (_filter == 'Oldest Tender') {
            _tenders = _tenders.where((tender) {
              try {
                return DateTime.parse(tender.lastDate).isBefore(DateTime.now());
              } catch (e) {
                return false;
              }
            }).toList();
          } else if (_filter == 'Newest Tender') {
            _tenders = _tenders.where((tender) {
              try {
                return DateTime.parse(tender.lastDate).isAfter(DateTime.now());
              } catch (e) {
                return false;
              }
            }).toList();
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return WideLayout(tenders: _tenders, onDelete: _deleteTender);
              } else {
                return NarrowLayout(tenders: _tenders, onDelete: _deleteTender);
              }
            },
          );
        },
      ),
    );
  }
}
