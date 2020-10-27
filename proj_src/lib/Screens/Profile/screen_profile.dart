import 'package:flutter/material.dart';

class Screen_Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: buildAppBar_Map(),
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "PROFILE PAGE",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
