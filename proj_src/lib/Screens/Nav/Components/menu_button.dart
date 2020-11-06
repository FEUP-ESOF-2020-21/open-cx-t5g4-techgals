import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Menu/screen_menu.dart';

// ignore: camel_case_types
class Menu_Button extends StatelessWidget {
  const Menu_Button({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.23,
      width: size.width * 0.2,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Screen_Menu();
              },
            ),
          );
        },
        icon: Icon(
          Icons.menu,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
