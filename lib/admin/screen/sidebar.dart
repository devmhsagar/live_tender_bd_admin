import 'package:flutter/material.dart';
import 'package:live_tender_bd_admin/admin/screen/sidebar_items.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[800],
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SidebarItem(Icons.list, 'All Tender', '/all-tender'),
          SidebarItem(Icons.input, 'Tender Input', '/tender-input'),
          SidebarItem(Icons.add_box, 'Add Tender Method', '/add-tender-method'),
          SidebarItem(Icons.add_location, 'Add Location', '/add-location'),
          SidebarItem(Icons.add_business, 'Add Department', '/add-department'),
          Spacer(),
          SidebarItem(Icons.logout, 'Logout', '/logout'),
        ],
      ),
    );
  }
}
