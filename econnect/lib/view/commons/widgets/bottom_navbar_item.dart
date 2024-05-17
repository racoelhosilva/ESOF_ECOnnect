import 'package:flutter/material.dart';

class BottomNavbarItem extends BottomNavigationBarItem {
  BottomNavbarItem({required IconData icon})
      : super(
          icon: _createItemIcon(icon),
          label: '-',
          backgroundColor: Colors.transparent,
        );

  static Widget _createItemIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Icon(icon),
    );
  }
}
