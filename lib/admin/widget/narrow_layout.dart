import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class NarrowLayout extends StatelessWidget {
  final List<String> department;
  final List<String> locations;
  final TextEditingController tenderIdController;
  final TextEditingController docPriceController;
  final TextEditingController tenderSecurityController;
  final TextEditingController methodController;
  final TextEditingController nameOfWorkController;
  final TextEditingController departmentController;
  final TextEditingController locationController;
  final TextEditingController liquidController;
  final TextEditingController similarController;
  final TextEditingController turnoverController;
  final TextEditingController tenderCapacityController;
  final TextEditingController othersController;
  final TextEditingController tenderLastDateController;

  final VoidCallback submitForm;

  const NarrowLayout({
    Key? key,
    required this.department,
    required this.locations,
    required this.tenderIdController,
    required this.docPriceController,
    required this.tenderSecurityController,
    required this.methodController,
    required this.nameOfWorkController,
    required this.departmentController,
    required this.locationController,
    required this.liquidController,
    required this.similarController,
    required this.turnoverController,
    required this.tenderCapacityController,
    required this.othersController,
    required this.tenderLastDateController,
    required this.submitForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownSearch<String>(
            items: department,
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
          ),
          const SizedBox(height: 16),
          DropdownSearch<String>(
            items: locations,
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
          ),
          // Remaining input fields and submit button
          ElevatedButton(
            onPressed: submitForm,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
