import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FoldersScreen extends StatelessWidget {
  const FoldersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: const Text('Center')),
      floatingActionButton: SpeedDial(
        spacing: 5,
        curve: Curves.bounceIn,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
            elevation: 0,
            child: Icon(FluentIcons.card_ui_24_regular),
            labelWidget: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: const Text('Добавить карточку'),
            ),
            onTap: () {},
          ),
          SpeedDialChild(
            elevation: 0,
            child: Icon(Icons.folder),
            labelWidget: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: const Text('Создать папку'),
            ),
            onTap: () {},
          ),
        ],
        child: Icon(Icons.add),
      ),
    );
  }
}
