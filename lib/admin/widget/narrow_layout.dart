import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:live_tender_bd_admin/admin/screen/tender_input_screen.dart';
import 'package:live_tender_bd_admin/admin/service/database.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
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

    void submitForm() async {
      final databaseMethods = DatabaseMethods();
      final tenderId = tenderIdController.text;
      final docPrice = docPriceController.text;
      final tenderSecurity = tenderSecurityController.text;
      final method = methodController.text;
      final nameOfWork = nameOfWorkController.text;
      final location = locationController.text;
      final liquid = liquidController.text;

      if (tenderId.isEmpty ||
          docPrice.isEmpty ||
          tenderSecurity.isEmpty ||
          method.isEmpty ||
          nameOfWork.isEmpty ||
          location.isEmpty ||
          liquid.isEmpty) {
        Fluttertoast.showToast(
          msg: "Please fill in all required fields.",
          toastLength: Toast.LENGTH_LONG,
        );
        return;
      }

      if (await databaseMethods.tenderIdExists(tenderId)) {
        Fluttertoast.showToast(
          msg: "Tender ID already exists. Please use a different ID.",
          toastLength: Toast.LENGTH_LONG,
        );
        return;
      }

      final uniqueId = databaseMethods.generateUniqueId();
      final tenderData = {
        'tenderId': tenderId,
        'docPrice': docPrice,
        'tenderSecurity': tenderSecurity,
        'method': method,
        'nameOfWork': nameOfWork,
        'department': departmentController.text,
        'location': location,
        'liquid': liquid,
        'similar': similarController.text,
        'turnover': turnoverController.text,
        'tenderCapacity': tenderCapacityController.text,
        'others': othersController.text,
      };

      try {
        await databaseMethods.addTender(tenderData, uniqueId);
        Fluttertoast.showToast(
          msg: "Tender submitted successfully!",
          toastLength: Toast.LENGTH_LONG,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error submitting tender: $e",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }

    return Column(
      children: [
        CustomTextField(controller: tenderIdController, labelText: 'Tender ID'),
        const SizedBox(height: 16),
        CustomTextField(controller: docPriceController, labelText: 'Doc Price'),
        const SizedBox(height: 16),
        CustomTextField(
            controller: tenderSecurityController, labelText: 'Tender Security'),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              labelText: 'Method', border: OutlineInputBorder()),
          items: ['LTM', 'OTM', 'CTM'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            methodController.text = newValue ?? '';
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(
            controller: nameOfWorkController,
            labelText: 'Name of Work',
            maxLines: 3),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              labelText: 'Department', border: OutlineInputBorder()),
          items: ['LGED', 'PWD', 'RHD'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            departmentController.text = newValue ?? '';
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
              labelText: 'Location', border: OutlineInputBorder()),
          items: ['Dhaka', 'Chittagong', 'Khulna'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            locationController.text = newValue ?? '';
          },
        ),
        const SizedBox(height: 16),
        CustomTextField(controller: liquidController, labelText: 'Liquid'),
        const SizedBox(height: 16),
        CustomTextField(controller: similarController, labelText: 'Similar'),
        const SizedBox(height: 16),
        CustomTextField(controller: turnoverController, labelText: 'Turnover'),
        const SizedBox(height: 16),
        CustomTextField(
            controller: tenderCapacityController, labelText: 'Tender Capacity'),
        const SizedBox(height: 16),
        CustomTextField(controller: othersController, labelText: 'Others'),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: submitForm,
            child: const Text('Submit'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
          ),
        ),
      ],
    );
  }
}
