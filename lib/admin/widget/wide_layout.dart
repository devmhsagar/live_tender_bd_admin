import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/widget/custom_text_field.dart';

class WideLayout extends StatelessWidget {
  final List<String> departments;
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
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      tenderLastDateController.text = picked.toString().split(" ")[0];
    }
  }

  const WideLayout({
    Key? key,
    required this.departments,
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
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                      controller: tenderIdController, labelText: 'Tender ID')),
              const SizedBox(width: 16),
              Expanded(
                  child: CustomTextField(
                      controller: docPriceController, labelText: 'Doc Price')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                      controller: tenderSecurityController,
                      labelText: 'Tender Security')),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Method', border: OutlineInputBorder()),
                  items: ['LTM', 'OTM', 'OSTETM', 'RFQU', 'RFQ']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    methodController.text = newValue ?? '';
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
              controller: nameOfWorkController,
              labelText: 'Name of Work',
              maxLines: 3),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Department', border: OutlineInputBorder()),
                  items: departments.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    departmentController.text = newValue ?? '';
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                      labelText: 'Location', border: OutlineInputBorder()),
                  items: locations.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    locationController.text = newValue ?? '';
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: liquidController,
                  decoration: const InputDecoration(
                    labelText: 'Liquid',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: similarController,
                  decoration: const InputDecoration(
                    labelText: 'Similar',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: tenderLastDateController,
                      decoration: const InputDecoration(
                        labelText: 'Last Date',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () {
                  _selectDate(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                      controller: turnoverController, labelText: 'Turnover')),
              const SizedBox(width: 16),
              Expanded(
                  child: CustomTextField(
                      controller: tenderCapacityController,
                      labelText: 'Tender Capacity')),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(controller: othersController, labelText: 'Others'),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: submitForm,
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
