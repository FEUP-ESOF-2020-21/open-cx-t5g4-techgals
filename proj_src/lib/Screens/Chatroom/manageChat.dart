import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/Screens/Nav/map1.dart';
import 'package:proj_src/constants.dart';

class ManageChat extends StatefulWidget {
  final String chatName;
  final String groupId;
  final String userName;
  ManageChat({this.chatName, this.groupId, this.userName});

  @override
  _ManageChat createState() => _ManageChat();
}

class _ManageChat extends State<ManageChat> {
  User _user = FirebaseAuth.instance.currentUser;
  List<String> _participants = [];
  String chatID = "";

  @override
  void initState() {
    super.initState();
    _getParticipants();
  }

  _getParticipants() async {
    QuerySnapshot _chatQS;
    await DatabaseMethods().getChat(widget.chatName).then((value) {
      setState(() {
        _chatQS = value;
      });
    });
    chatID = _chatQS.docs[0].id;
    _participants.clear();
    for (var i = 0; i < _chatQS.docs[0].get('participants').length; i++) {
      _participants.add(_chatQS.docs[0].get('participants')[i]);
    }
    _participants.forEach((element) {
      element.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar_Simple(context),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Stack(
            children: <Widget>[
              _participantsList(),
            ],
          )),
    );
  }

  Widget _participantsList() {
    return ListView.builder(
      itemCount: (_participants.length + 4), //snapshot.data.documents.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text(
            'Current Participants',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          );
        } else if (index == 1) {
          return Divider(
            height: 30,
          );
        } else if (index == 2) {
          return Divider(
            height: 30,
          );
        } else if (index >= 3 && index < (_participants.length + 3)) {
          return _participantTile(_participants[index - 3]);
        } else {
          return _deleteChatTile();
        }
      },
      scrollDirection: Axis.vertical,
    );
  }

  Widget _participantTile(String participant) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            k2PrimaryColor,
            kPrimaryColor,
          ]),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(participant,
                  style: TextStyle(fontSize: 17.0, color: Colors.white)),
              (widget.userName == participant)
                  ? Container()
                  : GestureDetector(
                      onTap: () async {
                        await HelperFunctions.getUserNameSharedPreference()
                            .then((val) {
                          DatabaseMethods(uid: _user.uid).updateChatInfo(
                              widget.groupId, participant, false);
                          _getParticipants();
                        });
                        await HelperFunctions.getUserNameSharedPreference()
                            .then((val) {
                          DatabaseMethods(uid: _user.uid)
                              .muteUser(widget.groupId, participant);
                        });
                      },
                      child: Icon(
                        Icons.remove_circle_outline_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _deleteChatTile() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Delete Chatroom',
                  style: TextStyle(fontSize: 18.0, color: Colors.white)),
              GestureDetector(
                onTap: () {
                  _popup(context);
                },
                child: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _popup(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = FlatButton(
      child: Text("Delete"),
      onPressed: () async {
        if (_participants.length > 1) {
          Navigator.of(context).pop();
        } else {
          await HelperFunctions.getUserNameSharedPreference().then((val) {
            DatabaseMethods(uid: _user.uid).deleteChatRoom(chatID);
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Map1();
              },
            ),
          );
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text.rich(
        TextSpan(
          text: 'Delete ', // default text style
          children: <TextSpan>[
            TextSpan(
                text: widget.chatName,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 19,
                )),
            TextSpan(
              text: ' ?',
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
      content: Text.rich(
        TextSpan(
          text: 'Are you ', // default text style
          children: <TextSpan>[
            TextSpan(
                text: 'sure',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.double,
                  decorationColor: Colors.red,
                  fontSize: 18,
                )),
            TextSpan(
              text: ' you want to delete this group chat?\n',
            ),
            TextSpan(
                text:
                    '\nThis action is irreversible and will only take place if no users are using the group chat.',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ))
          ],
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        cancelButton,
        deleteButton,
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
