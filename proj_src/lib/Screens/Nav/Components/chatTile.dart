import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Chatroom/chatroom.dart';
import 'package:proj_src/constants.dart';

class ChatTile extends StatelessWidget {
  final String userName;
  final String groupId;
  final String groupName;
  String _userName;
  int nbParticipants = 0;
  int nbMuted = 0;
  String admin = '';

  ChatTile({this.userName, this.groupId, this.groupName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await HelperFunctions.getUserNameSharedPreference().then((value) {
          _userName = value;
        });
        QuerySnapshot _groupQS;
        await DatabaseMethods().getChat(groupName).then((value) {
          _groupQS = value;
        });
        if(_groupQS != null && _groupQS.size > 0) {
          nbParticipants = _groupQS.docs[0].get('participants').length;
          nbMuted = _groupQS.docs[0].get('muted').length;
          admin = _groupQS.docs[0].get('admin');
        }
        _chatInfo(context);
        //DatabaseMethods().updateChatInfo(groupId, _userName, true);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(groupId: groupId, userName: userName, groupName: groupName,)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: k2PrimaryColor,
            child: Text(groupName.substring(0, 1).toUpperCase(), textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
          ),
          title: Text(groupName, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Join the conversation as $userName", style: TextStyle(fontSize: 13.0)),
        ),
      ),
    );
  }

  void _chatInfo(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget joinButton = FlatButton(
      child: Text("Join"),
      onPressed: () async {
        DatabaseMethods().updateChatInfo(groupId, _userName, true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(groupId: groupId, userName: userName, groupName: groupName,)));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(groupName.toUpperCase(), textAlign: TextAlign.center,),
      content:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Participants', style: TextStyle(fontSize: 17.0, color: Colors.black)),
                  Text(nbParticipants.toString(),
                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),)
                ],
              ),
              Container(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Muted', style: TextStyle(fontSize: 17.0, color: Colors.black)),
                  Text(nbMuted.toString(),
                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),)
                ],
              ),
              Container(height: 7,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Admin', style: TextStyle(fontSize: 17.0, color: Colors.black)),
                  Text(admin,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),)
                ],
              ),
            ],
          ),
      actions: [
        cancelButton,
        joinButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}