import 'package:flutter/material.dart';
import 'package:proj_src/constants.dart';

AppBar buildAppBar_Map() {
  return AppBar(
    elevation: 50,
    backgroundColor: kPrimaryColor,
    title: Text("APP_NAME"),
    leading: GestureDetector(
      onTap: () {},
      child: Icon(
        Icons.menu,
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8),
        child: IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
      )
    ],
  );
}
