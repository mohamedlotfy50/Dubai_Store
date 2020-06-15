import 'package:flutter/material.dart';

class DrawerTiles extends StatelessWidget {
  final String name;
  final Widget icon;
  final Function onpress;
  final bool isSelected;

  const DrawerTiles({
    this.name,
    this.icon,
    this.onpress,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      leading: icon,
      title: Text(name),
      onTap: onpress,
    );
  }
}
