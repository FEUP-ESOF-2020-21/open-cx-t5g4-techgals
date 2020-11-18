import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Nav/Map1/body_map1.dart';
import 'package:proj_src/Screens/Chatroom/information.dart';


class Chatroom_Button extends StatelessWidget {
  Chatroom_Button({
    Key key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.48,
      width: size.width * 0.73,

      child: IconButton(
        onPressed: () {
          return Information(0, "ESOF").showInfoChatroom(context);
        },
        
        icon: Icon(
          Icons.room,
          size: 60,
          color: Colors.white,
          semanticLabel: "No one here? Try another chatroom",
        ),
      ),
    );
  }
}