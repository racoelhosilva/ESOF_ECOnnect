import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.copyPlus),
      label: 'New Post',
    ),
  ];

  final List<String> _routes = const [
    '/home',
    '/new-post',
  ];

  String? _getCurrentRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }

  void _onTap(BuildContext context, String? currentRoute, int index) {
    String nextRoute = _routes[index];
    if (currentRoute != nextRoute) {
      Navigator.pushNamed(context, nextRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? route = _getCurrentRoute(context);

    return BottomNavigationBar(
      items: _items,
      selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
      unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
      onTap: (index) => _onTap(context, route, index),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 32,
      selectedFontSize: 0,
      unselectedFontSize: 0,
    );
  }
}
