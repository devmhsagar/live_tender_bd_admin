import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:live_tender_bd_admin/admin/service/database.dart';
import 'package:live_tender_bd_admin/admin/widget/narrow_layout.dart';
import 'package:live_tender_bd_admin/admin/widget/wide_layout.dart';

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

      // Clear form fields after a short delay
      setState(() {
        clearFormFields();
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error submitting tender: $e",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  void clearFormFields() {
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tender Insert Form',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return const WideLayout();
                } else {
                  return const NarrowLayout();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String labelText;
  final int maxLines;
  final TextEditingController controller;

  const CustomTextField({
    Key? key, // Make key parameter nullable
    required this.labelText,
    required this.controller,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
