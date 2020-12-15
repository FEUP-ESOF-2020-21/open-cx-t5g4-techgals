import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Chatroom/chatroom.dart';
import 'package:proj_src/constants.dart';

class ChatTile extends StatelessWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final double x;
  final double y;
  String _userName;

  ChatTile({this.userName, this.groupId, this.groupName, this.x, this.y});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int min = 100; //min and max values act as your 6 digit range
    int max = 999;
    var randomizer = new Random();
    return GestureDetector(
      /* onTap: () async {
        await HelperFunctions.getUserNameSharedPreference().then((value) {
          _userName = value;
        });
        DatabaseMethods().updateChatInfo(groupId, _userName, true);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      groupId: groupId,
                      userName: userName,
                      groupName: groupName,
                    )));
      },*/
      child: Container(
        //height: size.height * random,
        //width: size.width * random,
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
        /*child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: k2PrimaryColor,
            child: Text(groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
          title: Text(groupName, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Join the conversation as $userName",
              style: TextStyle(fontSize: 13.0)),
        ),*/
        child: Column(children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.place,
              size: 70,
              color: Colors.white, //white?
            ),
            tooltip: groupName,
            onPressed: () async {
              await HelperFunctions.getUserNameSharedPreference().then((value) {
                _userName = value;
              });
              DatabaseMethods().updateChatInfo(groupId, _userName, true);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatPage(
                            groupId: groupId,
                            userName: userName,
                            groupName: groupName,
                          )));
            },
          ),
          /*Text(groupName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                  backgroundColor: Colors.black)),*/
        ]),
      ),
    );
  }
}
