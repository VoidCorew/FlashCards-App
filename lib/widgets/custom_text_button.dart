import 'package:card_learn_languages/providers/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildTextButton(BuildContext context) {
  final currentTheme = context.watch<AppTheme>();

  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: currentTheme.isDark
          ? Colors.deepPurple
          : Colors.indigoAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    onPressed: () {},
    child: const Text('Продолжить'),
  );
}
