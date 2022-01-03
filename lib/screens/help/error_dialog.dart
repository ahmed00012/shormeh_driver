import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPopUp extends StatelessWidget {
  final String message;

  ErrorPopUp({ required this.message});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        "عذرا..",
        style: TextStyle(),
      ),
      content: Column(
        children: <Widget>[
          SizedBox(height: 8.0),
          Container(
            child: Text(
              "$message",
              style: TextStyle(),
            ),
          ),
          SizedBox(height: 24.0),
          RaisedButton(
            color: Colors.red,
            child: Text(
              "حسنا",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
