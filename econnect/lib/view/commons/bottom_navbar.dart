import 'package:econnect/view/commons/bottom_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({super.key, this.specialActions = const {}});

  final Map<String, void Function()> specialActions;

  final List<BottomNavigationBarItem> _items = [
    BottomNavbarItem(icon: LucideIcons.home),
    BottomNavbarItem(icon: LucideIcons.copyPlus),
  ];

  final List<String> _routes = const [
    '/home',
    '/createpost',
  ];

  String? _getCurrentRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name;
  }

  void _onTap(BuildContext context, String? currentRoute, int index) {
    String nextRoute = _routes[index];
    if (specialActions.containsKey(nextRoute)) {
      specialActions[nextRoute]!();
      return;
    }
    if (currentRoute != nextRoute) {
      Navigator.pushNamed(context, nextRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? route = _getCurrentRoute(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.1, 0.73, 1.0],
          colors: [
            Color(0xff1e1e1e),
            Color(0x991e1e1e),
            Color(0x001e1e1e),
          ],
        ),
      ),
      child: BottomNavigationBar(
        items: _items,
        selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        onTap: (index) => _onTap(context, route, index),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        iconSize: 32,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        elevation: 0,
      ),
    );
  }
}
