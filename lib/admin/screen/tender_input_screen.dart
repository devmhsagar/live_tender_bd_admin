import 'package:cloud_firestore/cloud_firestore.dart';
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
  final tenderLastDateController = TextEditingController();

  List<String> departments = [];
  List<String> locations = [];

  @override
  void initState() {
    super.initState();
    fetchDepartments();
    fetchLocations();
  }

  void fetchDepartments() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('departments').get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      departments = documents.map((doc) => doc['name'] as String).toList();
    });
  }

  void fetchLocations() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('locations').get();
    final List<DocumentSnapshot> documents = result.docs;
    setState(() {
      locations = documents.map((doc) => doc['name'] as String).toList();
    });
  }

  void submitForm() async {
    final databaseMethods = DatabaseMethods();
    final tenderId = tenderIdController.text.trim();
    final docPrice = docPriceController.text.trim();
    final tenderSecurity = tenderSecurityController.text.trim();
    final method = methodController.text.trim();
    final nameOfWork = nameOfWorkController.text.trim();
    final department = departmentController.text.trim();
    final location = locationController.text.trim();
    final liquid = liquidController.text.trim();
    final similar = similarController.text.trim();
    final turnover = turnoverController.text.trim();
    final tenderCapacity = tenderCapacityController.text.trim();
    final others = othersController.text.trim();
    final tenderLastDate = tenderLastDateController.text.trim();

    if (tenderId.isEmpty ||
        docPrice.isEmpty ||
        tenderSecurity.isEmpty ||
        method.isEmpty ||
        nameOfWork.isEmpty ||
        department.isEmpty ||
        location.isEmpty ||
        liquid.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill in all required fields.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    final tenderIdExists = await databaseMethods.tenderIdExists(tenderId);
    if (tenderIdExists) {
      Fluttertoast.showToast(
        msg: "Tender ID already exists.",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    final uniqueId = databaseMethods.generateUniqueId();
    final tenderDetails = {
      'tenderId': tenderId,
      'docPrice': docPrice,
      'tenderSecurity': tenderSecurity,
      'method': method,
      'nameOfWork': nameOfWork,
      'department': department,
      'location': location,
      'liquid': liquid,
      'similar': similar,
      'turnover': turnover,
      'tenderCapacity': tenderCapacity,
      'others': others,
      'tenderLastDate': tenderLastDate, 
    };

    await databaseMethods.addTender(tenderDetails, uniqueId);

    Fluttertoast.showToast(
      msg: "Tender details submitted successfully.",
      toastLength: Toast.LENGTH_LONG,
    );

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
    final isWideLayout = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tender Input Page'),
      ),
      body: isWideLayout
          ? WideLayout(
              departments: departments,
              locations: locations,
              tenderIdController: tenderIdController,
              docPriceController: docPriceController,
              tenderSecurityController: tenderSecurityController,
              methodController: methodController,
              nameOfWorkController: nameOfWorkController,
              departmentController: departmentController,
              locationController: locationController,
              liquidController: liquidController,
              similarController: similarController,
              turnoverController: turnoverController,
              tenderCapacityController: tenderCapacityController,
              othersController: othersController,
              tenderLastDateController: tenderLastDateController,
              submitForm: submitForm,
            )
          : NarrowLayout(
              departments: departments,
              locations: locations,
              tenderIdController: tenderIdController,
              docPriceController: docPriceController,
              tenderSecurityController: tenderSecurityController,
              methodController: methodController,
              nameOfWorkController: nameOfWorkController,
              departmentController: departmentController,
              locationController: locationController,
              liquidController: liquidController,
              similarController: similarController,
              turnoverController: turnoverController,
              tenderCapacityController: tenderCapacityController,
              othersController: othersController,
              tenderLastDateController: tenderLastDateController,
              submitForm: submitForm,
            ),
    );
  }
}
