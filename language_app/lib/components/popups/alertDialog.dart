import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String message, String routeToNextView) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      if (routeToNextView != null) {
        Navigator.pushNamed(context, routeToNextView);
      } else {
        Navigator.of(context).pop();
      }
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}