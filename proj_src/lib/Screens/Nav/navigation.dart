import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Nav/map1.dart';
import 'package:proj_src/Screens/Nav/map2.dart';

class NavigationMap extends StatefulWidget {
  @override
  _NavigationMapState createState() => _NavigationMapState();
}

class _NavigationMapState extends State<NavigationMap> {

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: [
        Map1(),
        Map2(),
      ],
    );
  }
}

