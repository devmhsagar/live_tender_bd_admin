import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_tender_bd_admin/admin/screen/header.dart';
import 'package:live_tender_bd_admin/admin/screen/main_controller.dart';
import 'package:live_tender_bd_admin/admin/screen/sidebar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: Row(
              children: [
                const Sidebar(),
                Expanded(
                  child: Obx(() {
                    final controller = Get.find<MainController>();
                    return controller.currentPage.value;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
