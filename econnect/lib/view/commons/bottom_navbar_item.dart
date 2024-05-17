import 'package:flutter/material.dart';

class BottomNavbarItem extends BottomNavigationBarItem {
  BottomNavbarItem({required IconData icon}): super(
          icon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Icon(
              icon,
            ),
          ),
          label: '-',
          backgroundColor: Colors.transparent,
        );
}
