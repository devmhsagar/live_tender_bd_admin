import 'package:flutter/material.dart';

class TenderFormPage extends StatelessWidget {
  const TenderFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(),
          Expanded(
            child: Row(
              children: [
                Sidebar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tender Insert Form',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth > 600) {
                                return WideLayout();
                              } else {
                                return NarrowLayout();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[700],
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://www.gravatar.com/avatar'), // Replace with your image URL
          ),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.grey[800],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const DrawerHeader(
          //   child: Text(
          //     'Live Tender BD',
          //     style: TextStyle(color: Colors.white, fontSize: 24),
          //   ),
          // ),
          SidebarItem(Icons.list, 'All Tender'),
          SidebarItem(Icons.input, 'Tender Input'),
          SidebarItem(Icons.add_box, 'Add Tender Method'),
          SidebarItem(Icons.add_location, 'Add Location'),
          SidebarItem(Icons.add_business, 'Add Department'),
          const Spacer(),
          SidebarItem(Icons.logout, 'Logout'),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;

  SidebarItem(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: () {
        // Handle navigation or other actions
      },
    );
  }
}

class WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: CustomTextField(labelText: 'Tender ID')),
            const SizedBox(width: 16),
            Expanded(child: CustomTextField(labelText: 'Doc Price')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: CustomTextField(labelText: 'Tender Security')),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Method', border: OutlineInputBorder()),
                items: ['LTM', 'OTM', 'CTM'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Name of Work', maxLines: 3),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Department', border: OutlineInputBorder()),
                items: ['LGED', 'PWD', 'RHD'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    labelText: 'Location', border: OutlineInputBorder()),
                items: ['Dhaka', 'Chittagong', 'Khulna'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: CustomTextField(labelText: 'Liquid')),
            const SizedBox(width: 16),
            Expanded(child: CustomTextField(labelText: 'Similar')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: CustomTextField(labelText: 'Turnover')),
            const SizedBox(width: 16),
            Expanded(child: CustomTextField(labelText: 'Tender Capacity')),
          ],
        ),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Others'),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle form submission
            },
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

class NarrowLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(labelText: 'Tender ID'),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Doc Price'),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Tender Security'),
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
          onChanged: (newValue) {},
        ),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Name of Work', maxLines: 3),
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
          onChanged: (newValue) {},
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
          onChanged: (newValue) {},
        ),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Liquid'),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Similar'),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Turnover'),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Tender Capacity'),
        const SizedBox(height: 16),
        CustomTextField(labelText: 'Others'),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle form submission
            },
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

class CustomTextField extends StatelessWidget {
  final String labelText;
  final int maxLines;

  CustomTextField({required this.labelText, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
    );
  }
}
