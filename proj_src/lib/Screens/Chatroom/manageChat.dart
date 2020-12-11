import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
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

  final AuthMethods _authMethods = new AuthMethods();
  User _user = FirebaseAuth.instance.currentUser;
  List<String> _participants = [];

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
    _participants.clear();
    for(var i = 0; i< _chatQS.docs[0].get('participants').length; i++) {
      _participants.add(_chatQS.docs[0].get('participants')[i]);
    }
    _participants.forEach((element) {element.toLowerCase();});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar_Simple(context),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Stack(
            children: <Widget> [
              _participantsList(),
            ],
          )
      ),
    );
  }

  Widget _participantsList() {
    return ListView.builder(
      itemCount: (_participants.length + 3),//snapshot.data.documents.length,
      itemBuilder: (context, index){
        if(index == 0) {
          return Text(
            'Current Participants',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          );
        }
        else if(index == 1) { return Divider(height: 30,); }
        else if(index == 2) { return Divider(height: 30,); }
        else {
          return _participantTile(_participants[index-3]);
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
          gradient: LinearGradient(
              colors: [
                k2PrimaryColor,
                kPrimaryColor,
              ]
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child:
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(participant, style: TextStyle(fontSize: 17.0, color: Colors.white)),
              (widget.userName == participant) ? Container() :
              GestureDetector(
                onTap: () async {
                  await HelperFunctions.getUserNameSharedPreference().then((val) {
                    DatabaseMethods(uid: _user.uid).updateChatInfo(widget.groupId, participant, false);
                    _getParticipants();
                  });
                },
                child: Icon(Icons.remove_circle_outline_rounded, color: Colors.white, size: 25,),
              )
            ],
          ),
        ),
      ),
    );
  }

}
