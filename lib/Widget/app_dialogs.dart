import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogs{
  CustomDialogs._();


  static Future<void> showDialogCustom(String title,String content ,BuildContext context) async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text("Close"))
              ]
          );
        }
    );
  }



}