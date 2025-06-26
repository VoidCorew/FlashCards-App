import 'package:card_learn_languages/screens/home/cards/cards_screen.dart';
import 'package:card_learn_languages/screens/home/folders/folders_screen.dart';
import 'package:flutter/material.dart';

class HomeTabBarScreen extends StatelessWidget {
  const HomeTabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [CardsScreen(), FoldersScreen()]);
  }
}
