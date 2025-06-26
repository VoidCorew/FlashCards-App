import 'package:flutter/material.dart';

class CustomSettingsBar extends StatelessWidget {
  final IconData tileIcon;
  final Color? tileIconColor;
  final String tileName;
  final Color? tileNameColor;
  final Widget? trailing;
  final Color? tileBackgroundColor;
  final BorderRadius borderRadius;
  const CustomSettingsBar({
    super.key,
    required this.tileIcon,
    this.tileIconColor,
    required this.tileName,
    this.tileNameColor,
    this.trailing,
    this.tileBackgroundColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 3),
      color: tileBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: ListTile(
        minTileHeight: 45,
        leading: Icon(tileIcon, color: tileIconColor),
        title: Text(
          tileName,
          style: TextStyle(color: tileNameColor, fontWeight: FontWeight.w600),
        ),
        trailing: trailing,
      ),
    );
  }
}
