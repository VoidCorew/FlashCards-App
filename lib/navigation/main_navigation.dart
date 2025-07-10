import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:card_learn_languages/screens/home/home_tab_bar_screen.dart';
import 'package:card_learn_languages/screens/quiz/quiz_selection_screen.dart';
import 'package:card_learn_languages/screens/settings_screen.dart';
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

  int currentScreenIndex = 0;
  final List<Widget> screens = const [
    HomeTabBarScreen(),
    // QuizSelectionScreen(),
    SettingsScreen(),
  ];
  final List<NavigationDestination> destinations = const [
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

  final List<String> titles = const ['Главная', 'Настройки'];

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppProvider>();

    final List<Widget> actions = currentScreenIndex == 0
        ? [
            IconButton(
              onPressed: () => context.read<AppProvider>().toggleTheme(),
              icon: Icon(
                currentTheme.isDark ? Icons.wb_sunny : Icons.nights_stay,
              ),
            ),

            // IconButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => SettingsScreen()),
            //     );
            //   },
            //   icon: Icon(Icons.settings),
            // ),
          ]
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentScreenIndex]),
        actions: actions,
        bottom: currentScreenIndex == 0
            ? TabBar(
                tabs: [
                  Tab(text: 'Слова'),
                  Tab(text: 'Папки'),
                ],
              )
            : null,
      ),
      body: currentScreenIndex == 0 ? HomeTabBarScreen() : SettingsScreen(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentScreenIndex = index;
          });
        },
        destinations: destinations,
      ),
    );
  }
}
