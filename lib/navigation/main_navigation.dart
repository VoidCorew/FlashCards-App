import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/screens/settings_screen.dart';
import 'package:card_learn_languages/tabs/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  ChangeNotifier currentTheme(BuildContext context) {
    final currentTheme = context.watch<AppProvider>();
    return currentTheme;
  }

  int _currentScreenIndex = 0;
  final List<Widget> _screens = const [TabsScreen(), SettingsScreen()];
  final List<NavigationDestination> _destinations = const [
    NavigationDestination(
      selectedIcon: Icon(Icons.home_rounded),
      icon: Icon(Icons.home_outlined),
      label: 'Главная',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.settings),
      icon: Icon(Icons.settings_outlined),
      label: 'Настройки',
    ),
  ];

  final List<NavigationRailDestination> _railDestinations = const [
    NavigationRailDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: Text('Главная'),
    ),
    NavigationRailDestination(
      selectedIcon: Icon(Icons.settings),
      icon: Icon(Icons.settings_outlined),
      label: Text('Настройки'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: isWide
          ? Row(
              children: [
                NavigationRail(
                  destinations: _railDestinations,
                  selectedIndex: _currentScreenIndex,
                  onDestinationSelected: (int value) {
                    setState(() {
                      _currentScreenIndex = value;
                    });
                  },
                  labelType: NavigationRailLabelType.selected,
                ),
                Expanded(child: _screens[_currentScreenIndex]),
              ],
            )
          : _currentScreenIndex == 0
          ? TabsScreen()
          : SettingsScreen(),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _currentScreenIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _currentScreenIndex = index;
                });
              },
              destinations: _destinations,
            ),
    );
  }
}
