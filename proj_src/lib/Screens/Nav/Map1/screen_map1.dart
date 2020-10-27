import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Nav/Map1/body_map1.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';

class Screen_Map1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: buildAppBar_Map(),
      body: Body(),
    );
  }
}
