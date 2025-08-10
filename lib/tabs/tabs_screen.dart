import 'package:card_learn_languages/navigation/main_navigation.dart';
import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/screens/home/cards/cards_screen.dart';
import 'package:card_learn_languages/screens/home/folders/folders_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final int _currentScreenIndex = 0;

  final List<String> titles = const ['Главная', 'Настройки'];

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppProvider>();
    final List<Widget> actions = _currentScreenIndex == 0
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('Главная'),
          title: Text(titles[_currentScreenIndex]),
          actions: actions,
          bottom: _currentScreenIndex == 0
              ? const TabBar(
                  tabs: [
                    Tab(text: 'Слова'),
                    Tab(text: 'Папки'),
                  ],
                )
              : null,
        ),
        body: const TabBarView(children: [CardsScreen(), FoldersScreen()]),
      ),
    );
  }
}
