import 'package:flutter/material.dart';

class WordsTabScreen extends StatelessWidget {
  const WordsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold());
  }
}
