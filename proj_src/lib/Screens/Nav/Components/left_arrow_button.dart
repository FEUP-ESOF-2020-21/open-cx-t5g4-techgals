import 'package:flutter/material.dart';
import '../map1.dart';

class Left_Arrow_Button extends StatelessWidget {
  const Left_Arrow_Button({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //height: size.height*0.75, with AppBar
      height: size.height*0.95,
      width: size.width*0.2,

      child: IconButton(
        onPressed: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return Map1();},),);},
        icon: Icon(
          Icons.arrow_back_ios,
          size: 50,
          color: Colors.white, //white?
          semanticLabel: "Like Nothing Here? Check the Other Room!",
        ),
      ),
    );
  }
}