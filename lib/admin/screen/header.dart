import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

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