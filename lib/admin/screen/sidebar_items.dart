import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_tender_bd_admin/admin/screen/main_controller.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;

  SidebarItem(this.icon, this.label, this.route);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Get.find<MainController>().navigateTo(route);
      },
    );
  }
}
