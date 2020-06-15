import 'package:dubai/pages/main_secreen/myapp_bar.dart';
import 'package:dubai/services/database.dart';
import 'package:flutter/material.dart';

class ReportError extends StatefulWidget {
  const ReportError({Key key}) : super(key: key);

  @override
  _ReportErrorState createState() => _ReportErrorState();
}

class _ReportErrorState extends State<ReportError> {
  final database = DataBaseService();
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Settings',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: new TextField(
                        onChanged: (val) {
                          message = val;
                        },
                        textAlign: TextAlign.start,
                        decoration: new InputDecoration(
                          hintText: 'write your problem',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: RaisedButton(
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          onPressed: () async {
                            await database.errorReport(error: message);
                            Navigator.of(context).pop();
                          },
                          child: Text('send report')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
