import 'package:flutter/material.dart';
import 'package:trackie_app/features/assistance/presentation/pages/assistance_page.dart';
import 'package:trackie_app/features/devices/presentation/pages/devices_page.dart';
import 'package:trackie_app/features/settings/presentation/pages/settings_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    AssistancePage(),
    DevicesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Assistente',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices_other),
            label: 'Dispositivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}