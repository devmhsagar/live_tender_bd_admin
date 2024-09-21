import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddLocationPage extends StatefulWidget {
  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final TextEditingController locationController = TextEditingController();

  // Function to add location to Firebase
  void addLocation() async {
    if (locationController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a location name.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('locations').add({
        'name': locationController.text,
      });
      Fluttertoast.showToast(
        msg: "Location added successfully!",
        toastLength: Toast.LENGTH_LONG,
      );
      locationController.clear();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error adding location: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Function to delete location from Firebase
  void deleteLocation(String id) async {
    try {
      await FirebaseFirestore.instance.collection('locations').doc(id).delete();
      Fluttertoast.showToast(
        msg: "Location deleted successfully!",
        toastLength: Toast.LENGTH_LONG,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error deleting location: $e",
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
              onPressed: addLocation,
              child: const Text('Add Location'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('locations')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final locations = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return ListTile(
                        title: Text(location['name']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteLocation(location.id),
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
