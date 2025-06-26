import 'package:flutter/material.dart';

class FlagEntry {
  final Widget name;
  final String value;

  const FlagEntry(this.name, this.value);
}

class CustomDropDownFlagMenu extends StatefulWidget {
  final String? initialFlag;
  final ValueChanged<String> onChanged;
  const CustomDropDownFlagMenu({
    super.key,
    required this.initialFlag,
    required this.onChanged,
  });

  @override
  State<CustomDropDownFlagMenu> createState() => _CustomDropDownFlagMenuState();
}

class _CustomDropDownFlagMenuState extends State<CustomDropDownFlagMenu> {
  late String? _selectedFlag;

  // static final List<DropdownMenuEntry<String>> _flags = [
  //   DropdownMenuEntry(value: '🇨🇳', label: '🇨🇳'),
  //   DropdownMenuEntry(value: 'Чили', label: '🇨🇱'),
  //   DropdownMenuEntry(value: 'Канада', label: '🇨🇦'),
  //   DropdownMenuEntry(value: 'Бразилия', label: '🇧🇷'),
  //   DropdownMenuEntry(value: 'Болгария', label: '🇧🇬'),
  //   DropdownMenuEntry(value: 'Испания', label: '🇪🇸'),
  //   DropdownMenuEntry(value: 'Франция', label: '🇫🇷'),
  //   DropdownMenuEntry(value: 'Великобритания', label: '🇬🇧'),
  //   DropdownMenuEntry(value: 'Грузия', label: '🇬🇪'),
  //   DropdownMenuEntry(value: 'Хорватия', label: '🇭🇷'),
  //   DropdownMenuEntry(value: 'Индия', label: '🇮🇳'),
  //   DropdownMenuEntry(value: 'США', label: '🇺🇸'),
  //   DropdownMenuEntry(value: 'Япония', label: '🇯🇵'),
  //   DropdownMenuEntry(value: 'Германия', label: '🇩🇪'),
  //   DropdownMenuEntry(value: 'Италия', label: '🇮🇹'),
  //   DropdownMenuEntry(value: 'Южная Корея', label: '🇰🇷'),
  //   DropdownMenuEntry(value: 'Австралия', label: '🇦🇺'),
  //   DropdownMenuEntry(value: 'Польша', label: '🇵🇱'),
  //   DropdownMenuEntry(value: 'Украина', label: '🇺🇦'),
  //   DropdownMenuEntry(value: 'Турция', label: '🇹🇷'),
  //   DropdownMenuEntry(value: 'Швеция', label: '🇸🇪'),
  //   DropdownMenuEntry(value: 'Нидерланды', label: '🇳🇱'),
  //   DropdownMenuEntry(value: 'Норвегия', label: '🇳🇴'),
  //   DropdownMenuEntry(value: 'Мексика', label: '🇲🇽'),
  // ];

  static final List<DropdownMenuEntry<String?>> _flags = [
    DropdownMenuEntry(value: null, label: 'нету'),
    DropdownMenuEntry(value: '🇨🇳', label: '🇨🇳'),
    DropdownMenuEntry(value: '🇨🇱', label: '🇨🇱'),
    DropdownMenuEntry(value: '🇨🇦', label: '🇨🇦'),
    DropdownMenuEntry(value: '🇧🇷', label: '🇧🇷'),
    DropdownMenuEntry(value: '🇧🇬', label: '🇧🇬'),
    DropdownMenuEntry(value: '🇪🇸', label: '🇪🇸'),
    DropdownMenuEntry(value: '🇫🇷', label: '🇫🇷'),
    DropdownMenuEntry(value: '🇬🇧', label: '🇬🇧'),
    DropdownMenuEntry(value: '🇬🇪', label: '🇬🇪'),
    DropdownMenuEntry(value: '🇭🇷', label: '🇭🇷'),
    DropdownMenuEntry(value: '🇮🇳', label: '🇮🇳'),
    DropdownMenuEntry(value: '🇺🇸', label: '🇺🇸'),
    DropdownMenuEntry(value: '🇯🇵', label: '🇯🇵'),
    DropdownMenuEntry(value: '🇩🇪', label: '🇩🇪'),
    DropdownMenuEntry(value: '🇮🇹', label: '🇮🇹'),
    DropdownMenuEntry(value: '🇰🇷', label: '🇰🇷'),
    DropdownMenuEntry(value: '🇦🇺', label: '🇦🇺'),
    DropdownMenuEntry(value: '🇵🇱', label: '🇵🇱'),
    DropdownMenuEntry(value: '🇺🇦', label: '🇺🇦'),
    DropdownMenuEntry(value: '🇹🇷', label: '🇹🇷'),
    DropdownMenuEntry(value: '🇸🇪', label: '🇸🇪'),
    DropdownMenuEntry(value: '🇳🇱', label: '🇳🇱'),
    DropdownMenuEntry(value: '🇳🇴', label: '🇳🇴'),
    DropdownMenuEntry(value: '🇲🇽', label: '🇲🇽'),
    // то, что хотела Настя
    DropdownMenuEntry(value: '🇦🇱', label: '🇦🇱'),
    DropdownMenuEntry(value: '🇫🇮', label: '🇫🇮'),
    DropdownMenuEntry(value: '🇬🇷', label: '🇬🇷'),
    DropdownMenuEntry(value: '🇷🇺', label: '🇷🇺'),
    DropdownMenuEntry(value: '🇪🇪', label: '🇪🇪'),
  ];

  // static final List<FlagEntry> _flags = [
  //   FlagEntry(const Text('Китай'), '🇨🇳'),
  //   FlagEntry(const Text('Чили'), '🇨🇱'),
  //   FlagEntry(const Text('Канада'), '🇨🇦'),
  //   FlagEntry(const Text('Бразилия'), '🇧🇷'),
  //   FlagEntry(const Text('Болгария'), '🇧🇬'),
  //   FlagEntry(const Text('Испания'), '🇪🇸'),
  //   FlagEntry(const Text('Франция'), '🇫🇷'),
  //   FlagEntry(const Text('Великобритания'), '🇬🇧'),
  //   FlagEntry(const Text('Грузия'), '🇬🇪'),
  //   FlagEntry(const Text('Хорватия'), '🇭🇷'),
  //   FlagEntry(const Text('Индия'), '🇮🇳'),
  //   FlagEntry(const Text('США'), '🇺🇸'),
  //   FlagEntry(const Text('Япония'), '🇯🇵'),
  //   FlagEntry(const Text('Германия'), '🇩🇪'),
  //   FlagEntry(const Text('Италия'), '🇮🇹'),
  //   FlagEntry(const Text('Южная Корея'), '🇰🇷'),
  //   FlagEntry(const Text('Австралия'), '🇦🇺'),
  //   FlagEntry(const Text('Польша'), '🇵🇱'),
  //   FlagEntry(const Text('Украина'), '🇺🇦'),
  //   FlagEntry(const Text('Турция'), '🇹🇷'),
  //   FlagEntry(const Text('Швеция'), '🇸🇪'),
  //   FlagEntry(const Text('Нидерланды'), '🇳🇱'),
  //   FlagEntry(const Text('Норвегия'), '🇳🇴'),
  //   FlagEntry(const Text('Мексика'), '🇲🇽'),
  // ];

  // static final List<DropdownMenuEntry<>>

  // String _selectedFlag = 'Китай';

  @override
  void initState() {
    super.initState();
    _selectedFlag = widget.initialFlag;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String?>(
      initialSelection: _selectedFlag,
      dropdownMenuEntries: _flags,
      menuHeight: 200,
      onSelected: (String? flag) {
        if (flag != null) {
          setState(() {
            _selectedFlag = flag;
          });
          widget.onChanged(flag);
        }
      },
    );
  }
}
