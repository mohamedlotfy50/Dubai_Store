import 'package:dubai/pages/main_secreen/cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyAppBar extends PreferredSize {
  @override
  Size get preferredSize => Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        title: Text('Dubai Store'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.shoppingCart,
              size: 22,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Cart();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
