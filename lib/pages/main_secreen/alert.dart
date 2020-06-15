import 'package:flutter/material.dart';

enum DialogActions { cancel }

class Dialogs {
  static Future<DialogActions> yesCancellDailog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(DialogActions.cancel);
                },
                child: Text('cancel'),
              ),
            ],
          );
        });
    return action != null ? action : DialogActions.cancel;
  }
}
