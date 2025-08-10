import 'package:card_learn_languages/models/folder.dart';
import 'package:card_learn_languages/models/save_card_colors.dart';
import 'package:card_learn_languages/models/save_theme.dart';
import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:card_learn_languages/models/save_cards.dart';
import 'package:card_learn_languages/navigation/main_navigation.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
import 'package:card_learn_languages/providers/folders_provider.dart';
import 'package:card_learn_languages/providers/save_card_colors_provider.dart';
import 'package:card_learn_languages/tabs/tabs_screen.dart';
// import 'package:card_learn_languages/theme/theme_app_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SaveCardsAdapter());
  Hive.registerAdapter(FolderAdapter());
  Hive.registerAdapter(AppSettingsAdapter());
  Hive.registerAdapter(AppThemeModeAdapter());
  Hive.registerAdapter(SaveCardColorsAdapter());

  await Hive.openBox<AppSettings>('app_settings');
  await Hive.openBox<SaveCards>('save_cards');
  await Hive.openBox<Folder>('folders');
  await Hive.openBox<String>('root_cards');
  await Hive.openBox<SaveCardColors>('save_card_colors');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => FoldersProvider()),
        ChangeNotifierProvider(create: (_) => SaveCardColorsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    if (!appProvider.isInitialized) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Learn Languages With Cards',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.red,
            // secondary: Colors.orange,
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            // backgroundColor: Colors.orange,
            backgroundColor: Colors.grey,
          ),
          // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //   selectedItemColor: Colors.brown,
          //   unselectedItemColor: Colors.green,
          //   backgroundColor: Colors.pink,
          //   selectedLabelStyle: TextStyle(fontFamily: 'wdxl'),
          //   unselectedLabelStyle: TextStyle(fontFamily: 'wdxl'),
          // ),
          tabBarTheme: TabBarThemeData(
            labelStyle: TextStyle(fontFamily: 'wdxl'),
            unselectedLabelStyle: TextStyle(fontFamily: 'wdxl'),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'wdxl',
              color: Colors.black,
              fontSize: 25,
            ),
            // toolbarTextStyle:
          ),
          navigationBarTheme: NavigationBarThemeData(
            // backgroundColor: Colors.grey,
            indicatorColor: Colors.red,
            // surfaceTintColor: Colors.brown,
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(fontFamily: 'wdxl'),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(primary: Colors.pink),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            // backgroundColor: Colors.amber,
            backgroundColor: Colors.blueGrey,
          ),
          tabBarTheme: TabBarThemeData(
            labelStyle: TextStyle(fontFamily: 'wdxl'),
            unselectedLabelStyle: TextStyle(fontFamily: 'wdxl'),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'wdxl',
              color: Colors.white,
              fontSize: 25,
            ),
            // toolbarTextStyle:
          ),
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: Colors.pink,
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(fontFamily: 'wdxl'),
            ),
          ),
          // textButtonTheme: TextButtonThemeData(
          //   style: ButtonStyle(
          //     backgroundColor: WidgetStatePropertyAll(Colors.greenAccent),
          //   ),
          // ),
          // elevatedButtonTheme: ElevatedButtonThemeData(
          //   style: ButtonStyle(
          //     backgroundColor: WidgetStatePropertyAll(Colors.greenAccent),
          //   ),
          // ),
        ),
        themeMode: appProvider.themeMode,
        home: const MainNavigation(),
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => const HomeScreen(),
        //   '/create_edit_card': (context) => CreateEditCardScreen(),
        // },
      ),
    );
  }
}
