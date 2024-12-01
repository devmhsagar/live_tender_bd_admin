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
        const SnackBar(content: Text('Tender deleted successfully')),
      );
    } catch (e) {
      // Revert UI changes if deletion fails
      setState(() {
        // Refetch data or restore the previous state
      });

      print('Error deleting tender: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete tender')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Tender List'),
        actions: [
          Container(
            width: 200,
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
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
            return const Center(child: CircularProgressIndicator());
          }

          // Convert Firestore data to List<Tender>
          List<Tender> fetchedTenders = snapshot.data!.docs.map((doc) {
            return Tender.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          // Apply search filter
          if (_searchQuery.isNotEmpty) {
            fetchedTenders = fetchedTenders.where((tender) {
              return tender.tenderId.contains(_searchQuery) ||
                  tender.nameOfWork.contains(_searchQuery) ||
                  tender.department.contains(_searchQuery) ||
                  tender.method.contains(_searchQuery) ||
                  tender.location.contains(_searchQuery) ||
                  tender.tenderLastDate.contains(_searchQuery);
            }).toList();
          }

          // Apply date filter
          if (_filter == 'Oldest Tender') {
            fetchedTenders = fetchedTenders.where((tender) {
              try {
                return DateTime.parse(tender.tenderLastDate)
                    .isBefore(DateTime.now());
              } catch (e) {
                return false; // Skip if date parsing fails
              }
            }).toList();

            // Sort by ascending order (oldest first)
            fetchedTenders.sort((a, b) {
              try {
                return DateTime.parse(a.tenderLastDate)
                    .compareTo(DateTime.parse(b.tenderLastDate));
              } catch (e) {
                return 0; // Do not sort if parsing fails
              }
            });
          } else if (_filter == 'Newest Tender') {
            fetchedTenders = fetchedTenders.where((tender) {
              try {
                return DateTime.parse(tender.tenderLastDate)
                    .isAfter(DateTime.now());
              } catch (e) {
                return false; // Skip if date parsing fails
              }
            }).toList();

            // Sort by descending order (newest first)
            fetchedTenders.sort((a, b) {
              try {
                return DateTime.parse(b.tenderLastDate)
                    .compareTo(DateTime.parse(a.tenderLastDate));
              } catch (e) {
                return 0; // Do not sort if parsing fails
              }
            });
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return WideLayout(
                    tenders: fetchedTenders, onDelete: _deleteTender);
              } else {
                return NarrowLayout(
                    tenders: fetchedTenders, onDelete: _deleteTender);
              }
            },
          );
        },
      ),
    );
  }
}
