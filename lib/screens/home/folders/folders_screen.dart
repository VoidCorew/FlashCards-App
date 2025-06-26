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
            child: Icon(Icons.ad_units),
            labelWidget: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: const Text('Hello'),
            ),
            onTap: () {},
          ),
          SpeedDialChild(
            elevation: 0,
            child: Icon(Icons.ad_units),
            labelWidget: const Text('Hello'),
            onTap: () {},
          ),
        ],
        child: Icon(Icons.add),
      ),
    );
  }
}
