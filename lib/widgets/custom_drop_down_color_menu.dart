import 'dart:collection';

import 'package:flutter/material.dart';

class ColorEntry {
  final String name;
  final Color color;

  const ColorEntry(this.name, this.color);
}

const List<String> list = <String>[];
// const List<MapEntry<String, Color>> colorsList = [
//   MapEntry('Красный', Colors.red),
//   MapEntry('Красный', Colors.orange),
//   MapEntry('Красный', Colors.yellow),
//   MapEntry('Красный', Colors.blue),
//   MapEntry('Красный', Colors.green),
// ];

class CustomDropDownColorMenu extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onChanged;

  const CustomDropDownColorMenu({
    super.key,
    required this.initialColor,
    required this.onChanged,
  });

  @override
  State<CustomDropDownColorMenu> createState() =>
      _CustomDropDownColorMenuState();
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _CustomDropDownColorMenuState extends State<CustomDropDownColorMenu> {
  late Color _selectedColor;

  // static final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
  //   list.map<MenuEntry>((String name) => MenuEntry(value: name, label: name)),
  // );

  // static final DropDown

  // static final List<ColorEntry> _colorsList = [
  //   ColorEntry(
  //     const Text('Красный', style: TextStyle(fontFamily: 'wdxl')),
  //     Colors.red,
  //   ),
  //   ColorEntry(
  //     const Text('Оранжевый', style: TextStyle(fontFamily: 'wdxl')),
  //     Colors.orange,
  //   ),
  //   ColorEntry(
  //     const Text('Желтый', style: TextStyle(fontFamily: 'wdxl')),
  //     Colors.yellow,
  //   ),
  //   ColorEntry(
  //     const Text('Синий', style: TextStyle(fontFamily: 'wdxl')),
  //     Colors.blue,
  //   ),
  //   ColorEntry(
  //     const Text('Зеленый', style: TextStyle(fontFamily: 'wdxl')),
  //     Colors.green,
  //   ),
  // ];

  static final List<ColorEntry> _colorsList = [
    ColorEntry('Красный', Colors.red),
    ColorEntry('Оранжевый', Colors.orange),
    ColorEntry('Желтый', Colors.yellow),
    ColorEntry('Синий', Colors.blue),
    ColorEntry('Зеленый', Colors.green),
  ];

  static final List<DropdownMenuEntry<Color>> _menuEntries =
      UnmodifiableListView(
        _colorsList.map(
          (entry) =>
              DropdownMenuEntry<Color>(value: entry.color, label: entry.name),
        ),
      );

  // Color _selectedColor = Colors.red;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: _selectedColor,
      dropdownMenuEntries: _menuEntries,
      menuHeight: 200,
      onSelected: (Color? color) {
        if (color != null) {
          setState(() {
            _selectedColor = color;
          });
          widget.onChanged(color);
        }
      },
    );
  }
}
