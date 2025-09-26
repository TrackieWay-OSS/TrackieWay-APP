import 'package:flutter/material.dart';
import 'package:trackie_app/core/services/activation_service.dart';
import 'package:trackie_app/features/assistance/presentation/pages/assistance_page.dart';
import 'package:trackie_app/features/devices/presentation/pages/devices_page.dart';
import 'package:trackie_app/features/settings/presentation/pages/settings_page.dart';

// 1. Transforme em StatefulWidget
class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;
  // 2. Crie uma instância do serviço
  ActivationService? _activationService;

  final List<Widget> _pages = [
    const AssistancePage(),
    const DevicesPage(),
    const SettingsPage(),
  ];

  // 3. Inicialize o serviço no initState
  @override
  void initState() {
    super.initState();
    // O serviço precisa do BuildContext, então inicializamos após o primeiro frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _activationService = ActivationService(context);
    });
  }

  // 4. Finalize o serviço no dispose
  @override
  void dispose() {
    _activationService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant),
            label: 'Assistência',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Dispositivos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}