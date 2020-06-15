import 'package:flutter/material.dart';

class TopShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ZigZagClipper(),
      child: Container(
          width: double.infinity,
          height: 250,
          color: Color(0xFF69EBD0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Image.asset(
                'images/logo.png',
                width: 150,
              ),
              Text(
                'DUBAI',
                style: TextStyle(
                    fontSize: 34,
                    color: Color(0xFF757076),
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 70, size.width / 2, size.height - 35);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 25);
    path.lineTo(size.width,
        0); // this draws the line from current point to the right top position of the widget
    path.close(); // this closes the loop from current position to the starting point of widget
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
