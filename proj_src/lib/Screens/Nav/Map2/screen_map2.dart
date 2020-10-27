import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Nav/Map2/body_map2.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';

class Screen_Map2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: buildAppBar_Map(),
      body: Body(),
    );
  }
}
