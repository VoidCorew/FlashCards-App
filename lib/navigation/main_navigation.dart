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
    final currentTheme = context.watch<AppTheme>();
    return currentTheme;
  }

  int currentScreenIndex = 0;
  final List<Widget> screens = const [
    HomeTabBarScreen(),
    QuizSelectionScreen(),
  ];
  final List<NavigationDestination> destinations = const [
    NavigationDestination(
      selectedIcon: Icon(Icons.home_rounded),
      icon: Icon(Icons.home_outlined),
      label: 'Главная',
    ),
    NavigationDestination(
      selectedIcon: Icon(Icons.quiz),
      icon: Icon(Icons.quiz_outlined),
      label: 'Викторина',
    ),
  ];

  final List<String> titles = const ['Главная', 'Викторина'];

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.watch<AppTheme>();
    // final isDarkTheme =
    //     (mode == ThemeMode.dark) ||
    //     (mode == ThemeMode.system &&
    //         Theme.of(context).brightness == Brightness.dark);

    // final destinations = const [
    //   NavigationDestination(
    //     selectedIcon: Icon(Icons.home_rounded),
    //     icon: Icon(Icons.home_outlined),
    //     label: 'Home',
    //   ),
    //   NavigationDestination(
    //     selectedIcon: Icon(
    //       Icons.quiz,
    //       // color: currentTheme.isDark ? null : Colors.white,
    //     ),
    //     icon: Icon(Icons.quiz_outlined),
    //     label: 'Quiz',
    //   ),
    // ];

    // final List<List<Widget>> _actions = [
    //   [
    //     IconButton(
    //       onPressed: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => SettingsScreen()),
    //         );
    //       },
    //       icon: Icon(Icons.settings),
    //     ),
    //   ],
    //   [],
    // ];

    final List<Widget> actions = currentScreenIndex == 0
        ? [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: Icon(Icons.settings),
            ),
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
                  Tab(text: 'Карточки'),
                ],
              )
            : null,
      ),
      // body: screens[currentScreenIndex],
      // body: currentScreenIndex == 0
      //     ? DefaultTabController(
      //         length: 2,
      //         child: Column(
      //           children: [
      //             TabBar(
      //               tabs: [
      //                 Tab(text: 'Слова'),
      //                 Tab(text: 'Папки'),
      //               ],
      //             ),
      //             Expanded(
      //               child: TabBarView(
      //                 children: [HomeScreen(), FoldersScreen()],
      //               ),
      //             ),
      //           ],
      //         ),
      //       )
      //     : QuizSelectionScreen(),
      body: currentScreenIndex == 0
          ? HomeTabBarScreen()
          : QuizSelectionScreen(),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: currentTheme.isDark
              ? Colors.deepPurple
              : Colors.indigoAccent,
          // iconTheme: WidgetStatePropertyAll(
          //   IconThemeData(color: currentTheme.isDark ? null : Colors.white),
          // ),
        ),
        child: NavigationBar(
          selectedIndex: currentScreenIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentScreenIndex = index;
            });
          },
          destinations: destinations,
        ),
      ),
    );
  }
}
