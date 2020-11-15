import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/Screens/Nav/Components/right_arrow_button.dart';

class Map1 extends StatefulWidget {
  @override
  _Map1State createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar_Map(context),
      body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/map1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Right_Arrow_Button(),
          //Menu_Button(),
          //Profile_Button(),
        ],
      ),
    ),
    );
  }
}
