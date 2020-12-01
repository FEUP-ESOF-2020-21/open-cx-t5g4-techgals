import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/Screens/Nav/Components/right_arrow_button.dart';
import 'package:proj_src/constants.dart';
import 'package:proj_src/Screens/Nav/Components/chatTile.dart';

class Map1 extends StatefulWidget {
  @override
  _Map1State createState() => _Map1State();
}

class _Map1State extends State<Map1> {
  
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapshot;
  Stream<QuerySnapshot> _groups;
  User _user = FirebaseAuth.instance.currentUser;
  String _userName = '';
  String _email= '';

  @override
  void initState() {
    super.initState();
    _getInfo();
    //initiateSearch();
  }

  _getInfo() async {
    await HelperFunctions.getUserNameSharedPreference().then((value) {
      setState(() {
        _userName = value;
      });
    });
    await DatabaseMethods().getActiveChats().then((val) {
      setState(() {
        _groups = val;
      });
    });
    await HelperFunctions.getUserEmailSharedPreference().then((value) {
      setState(() {
        _email = value;
      });
    });
  }

  Widget _listChats() {
    return StreamBuilder(
        stream: _groups,
        builder: (context, snapshot) {
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatTile(
                  userName: _userName,
                  groupId: snapshot.data.documents[index].id,
                  groupName: snapshot.data.documents[index]['name']
              );
              },
            scrollDirection: Axis.vertical,
            )
              :
          Container();
          }
    );
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        itemCount: searchSnapshot.docs.length,
        itemBuilder: (context, index) {
          return SearchItem(
              searchSnapshot.docs[index]["name"]
          );
        }) : Container();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar_Map(context),
      body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/map1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Right_Arrow_Button(),
          /*GestureDetector(
            onTap: (){
              initiateSearch();
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 35,
              ),
            ),
          ),*/
          //searchList(),
          _listChats()
          //Menu_Button(),
          //Profile_Button(),
        ],
      ),
    ),
    );
  }
}

class SearchItem extends StatelessWidget {

  final String username;
  SearchItem(this.username);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(this.username),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryLightColor,
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }
}
