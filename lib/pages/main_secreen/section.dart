import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String sectionName;
  final String sectionImage;
  final Function onPress;

  const Section({
    this.sectionName,
    this.sectionImage,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                sectionName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              FlatButton(onPressed: onPress, child: Text('See more'))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: onPress,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  image: DecorationImage(
                      image: NetworkImage(
                        sectionImage,
                      ),
                      fit: BoxFit.cover)),
            ),
          ),
        ],
      ),
    );
  }
}
