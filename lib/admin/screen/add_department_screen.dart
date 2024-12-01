import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InsertDepartmentForm extends StatefulWidget {
  @override
  _InsertDepartmentFormState createState() => _InsertDepartmentFormState();
}

class _InsertDepartmentFormState extends State<InsertDepartmentForm> {
  final TextEditingController departmentController = TextEditingController();

  // Function to add department to Firebase
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

  // Function to delete department from Firebase
  void deleteDepartment(String id) async {
    try {
      await FirebaseFirestore.instance.collection('departments').doc(id).delete();
      Fluttertoast.showToast(
        msg: "Department deleted successfully!",
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error deleting department: $e",
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
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('departments').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final departments = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: departments.length,
                    itemBuilder: (context, index) {
                      final department = departments[index];
                      return ListTile(
                        title: Text(department['name']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteDepartment(department.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
