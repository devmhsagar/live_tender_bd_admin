import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_tender_bd_admin/admin/screen/main_controller.dart';
import 'package:live_tender_bd_admin/admin/screen/sidebar.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.grey[800], // Match the sidebar color
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              mainController.navigateTo('/logout');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Desktop view with fixed sidebar
            return Row(
              children: [
                const Sidebar(),
                Expanded(
                  child: GetBuilder<MainController>(
                    builder: (_) {
                      return mainController.currentPage;
                    },
                  ),
                ),
              ],
            );
          } else {
            // Mobile view with drawer
            return Scaffold(
              appBar: AppBar(
                title: const Text('Admin Dashboard'),
                backgroundColor: Colors.grey[800],
                elevation: 5,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              drawer: const Drawer(
                child: Sidebar(),
              ),
              body: GetBuilder<MainController>(
                builder: (_) {
                  return mainController.currentPage;
                },
              ),
            );
          }
        },
      ),
    );
  }
}
