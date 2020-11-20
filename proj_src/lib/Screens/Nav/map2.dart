import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/Screens/Nav/Components/left_arrow_button.dart';

class Map2 extends StatefulWidget {
  @override
  _Map2State createState() => _Map2State();
}

class _Map2State extends State<Map2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar_Map(context),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/map2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Left_Arrow_Button(),
            //Menu_Button(),
            //Profile_Button(),
          ],
        ),
      ),
    );
  }
}
