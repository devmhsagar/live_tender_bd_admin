import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditTenderPage extends StatefulWidget {
  final String tenderId;

  EditTenderPage({required this.tenderId});

  @override
  _EditTenderPageState createState() => _EditTenderPageState();
}

class _EditTenderPageState extends State<EditTenderPage> {
  final tenderIdController = TextEditingController();
  final docPriceController = TextEditingController();
  final tenderSecurityController = TextEditingController();
  final methodController = TextEditingController();
  final nameOfWorkController = TextEditingController();
  final departmentController = TextEditingController();
  final locationController = TextEditingController();
  final tenderLastDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTenderData();
  }

  Future<void> _loadTenderData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('tenders')
        .doc(widget.tenderId)
        .get();

    Map<String, dynamic> tenderData = doc.data() as Map<String, dynamic>;

    setState(() {
      tenderIdController.text = tenderData['tenderId'];
      docPriceController.text = tenderData['docPrice'];
      tenderSecurityController.text = tenderData['tenderSecurity'];
      methodController.text = tenderData['method'];
      nameOfWorkController.text = tenderData['nameOfWork'];
      departmentController.text = tenderData['department'];
      locationController.text = tenderData['location'];
      tenderLastDateController.text = tenderData['tenderLastDate'];
    });
  }

  Future<void> _updateTender() async {
    try {
      await FirebaseFirestore.instance
          .collection('tenders')
          .doc(widget.tenderId)
          .update({
        'tenderId': tenderIdController.text.trim(),
        'docPrice': docPriceController.text.trim(),
        'tenderSecurity': tenderSecurityController.text.trim(),
        'method': methodController.text.trim(),
        'nameOfWork': nameOfWorkController.text.trim(),
        'department': departmentController.text.trim(),
        'location': locationController.text.trim(),
        'tenderLastDate': tenderLastDateController.text.trim(),
      });

      Fluttertoast.showToast(
        msg: "Tender updated successfully.",
        toastLength: Toast.LENGTH_LONG,
      );
      Navigator.of(context).pop(); // Go back after successful update
    } catch (e) {
      print('Error updating tender: $e');
      Fluttertoast.showToast(
        msg: "Failed to update tender.",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tender'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tenderIdController,
                decoration: InputDecoration(
                  labelText: 'Tender ID',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: docPriceController,
                decoration: InputDecoration(
                  labelText: 'Doc Price',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: tenderSecurityController,
                decoration: InputDecoration(
                  labelText: 'Tender Security',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: methodController,
                decoration: InputDecoration(
                  labelText: 'Method',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameOfWorkController,
                decoration: InputDecoration(
                  labelText: 'Name of Work',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: departmentController,
                decoration: InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: tenderLastDateController,
                decoration: InputDecoration(
                  labelText: 'Last Date',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    tenderLastDateController.text =
                        pickedDate.toString().split(' ')[0];
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateTender,
                child: Text('Update Tender'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
