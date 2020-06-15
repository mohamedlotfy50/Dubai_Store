import 'package:flutter/material.dart';

class RoundButtonIcon extends StatelessWidget {
  final Color color;
  final Widget icon;
  final Function onpress;

  const RoundButtonIcon({Key key, this.color, this.icon, this.onpress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        color: Colors.white,
        icon: icon,
        onPressed: onpress,
      ),
    );
  }
}
