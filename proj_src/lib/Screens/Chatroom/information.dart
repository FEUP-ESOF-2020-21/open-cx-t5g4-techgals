import 'package:flutter/material.dart';

// ignore: camel_case_types
class Information{
  int nr_people;
  String theme;

  Information(this.nr_people, this.theme);

  showInfoChatroom(BuildContext context) {
    // set up the button
    Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {
      nr_people++;
      Navigator.of(context).pop();
    },
  );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0)), //this right here
      title: Text("Chatroom"),
      content: Text("Welcome, click continue to enter the chatroom\n\nNº of people: $nr_people\nTheme: $theme"),
      actions: [
        cancelButton,
        continueButton,
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
}