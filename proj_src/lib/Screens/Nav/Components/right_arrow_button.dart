import 'package:flutter/material.dart';
import '../map2.dart';

// ignore: camel_case_types
class Right_Arrow_Button extends StatelessWidget {
  const Right_Arrow_Button({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //height: size.height*0.75, with AppBar
      height: size.height * 0.95,
      padding: EdgeInsets.only(left: 330),
      child: IconButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context){return Map2();},),);},
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 50,
          color: Colors.white, //white?
          semanticLabel: "Like Nothing Here? Check the Other Room!",
        ),
      ),
    );
  }
}
