import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InsertDepartmentForm extends StatelessWidget {
  final TextEditingController departmentController = TextEditingController();

  void addDepartment() async {
    if (departmentController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a department name.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('departments').add({
        'name': departmentController.text,
      });
      Fluttertoast.showToast(
        msg: "Department added successfully!",
        toastLength: Toast.LENGTH_LONG,
      );
      departmentController.clear();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error adding department: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Department'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: departmentController,
              decoration: InputDecoration(
                labelText: 'Department Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addDepartment,
              child: Text('Add Department'),
            ),
          ],
        ),
      ),
    );
  }
}
