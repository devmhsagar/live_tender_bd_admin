import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TenderInputPage extends StatefulWidget {
  const TenderInputPage({Key? key}) : super(key: key);

  @override
  _TenderInputPageState createState() => _TenderInputPageState();
}

class _TenderInputPageState extends State<TenderInputPage> {
  final tenderIdController = TextEditingController();
  final docPriceController = TextEditingController();
  final tenderSecurityController = TextEditingController();
  final methodController = TextEditingController();
  final nameOfWorkController = TextEditingController();
  final departmentController = TextEditingController();
  final locationController = TextEditingController();
  final liquidController = TextEditingController();
  final similarController = TextEditingController();
  final turnoverController = TextEditingController();
  final tenderCapacityController = TextEditingController();
  final othersController = TextEditingController();
  final tenderLastDateController = TextEditingController();

  bool isDuplicateTenderId = false;

  @override
  void initState() {
    super.initState();
    tenderIdController.addListener(() {
      checkDuplicateTenderId(tenderIdController.text);
    });
  }

  // Function to check if tenderId is duplicate
  Future<void> checkDuplicateTenderId(String tenderId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('tenders')
        .where('tenderId', isEqualTo: tenderId.trim())
        .get();

    setState(() {
      isDuplicateTenderId = querySnapshot.docs.isNotEmpty;
    });
  }

  Future<List<String>> fetchDepartments() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('departments').get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.map((doc) => doc['name'] as String).toList();
  }

  Future<List<String>> fetchLocations() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('locations').get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.map((doc) => doc['name'] as String).toList();
  }

  void addDepartment(String newDepartment) async {
    await FirebaseFirestore.instance
        .collection('departments')
        .add({'name': newDepartment});
    setState(() {
      fetchDepartments();
    });
  }

  void addLocation(String newLocation) async {
    await FirebaseFirestore.instance
        .collection('locations')
        .add({'name': newLocation});
    setState(() {
      fetchLocations();
    });
  }

  void showAddDialog(BuildContext context, String fieldType) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New $fieldType'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter $fieldType'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  if (fieldType == 'Department') {
                    addDepartment(controller.text.trim());
                  } else if (fieldType == 'Location') {
                    addLocation(controller.text.trim());
                  }
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // This function will submit the form data to Firestore
  void submitForm() async {
    // Ensure required fields are not empty
    if (tenderIdController.text.isEmpty ||
        nameOfWorkController.text.isEmpty ||
        departmentController.text.isEmpty ||
        locationController.text.isEmpty ||
        docPriceController.text.isEmpty ||
        tenderSecurityController.text.isEmpty ||
        methodController.text.isEmpty ||
        liquidController.text.isEmpty ||
        tenderLastDateController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in all required fields.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    // Check if tenderId is duplicate before submission
    if (isDuplicateTenderId) {
      Fluttertoast.showToast(
        msg: "Tender ID already exists. Please use a different ID.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    // Submit to Firestore
    await FirebaseFirestore.instance.collection('tenders').add({
      'tenderId': tenderIdController.text.trim(),
      'docPrice': docPriceController.text.trim(),
      'tenderSecurity': tenderSecurityController.text.trim(),
      'method': methodController.text.trim(),
      'nameOfWork': nameOfWorkController.text.trim(),
      'department': departmentController.text.trim(),
      'location': locationController.text.trim(),
      'liquid': liquidController.text.trim(),
      'similar': similarController.text.trim(),
      'turnover': turnoverController.text.trim(),
      'tenderCapacity': tenderCapacityController.text.trim(),
      'others': othersController.text.trim(),
      'tenderLastDate': tenderLastDateController.text.trim(),
    });

    // Show success message
    Fluttertoast.showToast(
      msg: "Tender details submitted successfully.",
      toastLength: Toast.LENGTH_LONG,
    );

    // Clear all fields after submitting
    tenderIdController.clear();
    docPriceController.clear();
    tenderSecurityController.clear();
    methodController.clear();
    nameOfWorkController.clear();
    departmentController.clear();
    locationController.clear();
    liquidController.clear();
    similarController.clear();
    turnoverController.clear();
    tenderCapacityController.clear();
    othersController.clear();
    tenderLastDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tender Input Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: tenderIdController,
                      decoration: InputDecoration(
                        labelText: 'Tender ID',
                        border: const OutlineInputBorder(),
                        errorText: isDuplicateTenderId
                            ? 'Tender ID already exists'
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: docPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Doc Price',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: tenderSecurityController,
                      decoration: const InputDecoration(
                        labelText: 'Tender Security',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownSearch<String>(
                      items: ['LTM', 'OTM', 'OSTETM', 'RFQU', 'RFQ'],
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Method",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (newValue) {
                        methodController.text = newValue ?? '';
                      },
                      selectedItem: methodController.text,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameOfWorkController,
                decoration: const InputDecoration(
                  labelText: 'Name of Work',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                      asyncItems: (String? filter) => fetchDepartments(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Department",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (newValue) {
                        departmentController.text = newValue ?? '';
                      },
                      selectedItem: departmentController.text,
                      popupProps: PopupProps.menu(
                        showSearchBox: true, // Enable search box
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showAddDialog(context, 'Department');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownSearch<String>(
                      asyncItems: (String? filter) => fetchLocations(),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Location",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      onChanged: (newValue) {
                        locationController.text = newValue ?? '';
                      },
                      selectedItem: locationController.text,
                      popupProps: PopupProps.menu(
                        showSearchBox: true, // Enable search box
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      showAddDialog(context, 'Location');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: liquidController,
                      decoration: const InputDecoration(
                        labelText: 'Liquid',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: similarController,
                      decoration: const InputDecoration(
                        labelText: 'Similar',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
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
                      child: AbsorbPointer(
                        child: TextField(
                          controller: tenderLastDateController,
                          decoration: const InputDecoration(
                            labelText: 'Last Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: turnoverController,
                      decoration: const InputDecoration(
                        labelText: 'Turnover',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: tenderCapacityController,
                      decoration: const InputDecoration(
                        labelText: 'Tender Capacity',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: othersController,
                decoration: const InputDecoration(
                  labelText: 'Others',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
