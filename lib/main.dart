import 'package:card_learn_languages/providers/app_provider.dart';
import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:card_learn_languages/models/save_cards.dart';
import 'package:card_learn_languages/navigation/main_navigation.dart';
import 'package:card_learn_languages/providers/card_provider.dart';
// import 'package:card_learn_languages/theme/theme_app_data.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SaveCardsAdapter());
  await Hive.openBox<SaveCards>('save_cards');
  await Hive.openBox('app_settings');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => CardProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<AppTheme>().currentMode;
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Learn Languages With Cards',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeMode,
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
