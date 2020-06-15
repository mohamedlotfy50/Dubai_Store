import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String categoryImage;
  final Function onpress;

  const CategoryCard({this.categoryName, this.categoryImage, this.onpress});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(categoryImage),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              categoryName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
