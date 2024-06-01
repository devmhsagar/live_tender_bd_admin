import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddLocationPage extends StatelessWidget {
  final TextEditingController locationController = TextEditingController();

  void addDepartment() async {
    if (locationController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a Location name.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('locations').add({
        'name': locationController.text,
      });
      Fluttertoast.showToast(
        msg: "locations added successfully!",
        toastLength: Toast.LENGTH_LONG,
      );
      locationController.clear();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error adding locations: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addDepartment,
              child: const Text('Add Location'),
            ),
          ],
        ),
      ),
    );
  }
}
