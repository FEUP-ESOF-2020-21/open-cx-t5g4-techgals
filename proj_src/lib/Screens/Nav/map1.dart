import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/database.dart';
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
  Stream _groups;

  initiateSearch(){
    //fixed for now
    databaseMethods.getUserByUsername("user_name").then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget listChats() {
    return StreamBuilder(
      stream: _groups,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data["chats"] != null) {
              if(snapshot.data["chats"].length != 0) {
                return ListView.builder(
                    itemCount: snapshot.data["chat"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                    int reqIndex = snapshot.data["chats"].length - index -1;
                    return ChatTile(userName: "user", groupId: "VXj0WwAPa4i7ArixDCxi", groupName: "chatroom");
                    }
                );
              }
              else{
                return Container();
              }
            }
            else {
              return Container();
            }
          }
          else {
            return ChatTile(userName: "user", groupId: "VXj0WwAPa4i7ArixDCxi", groupName: "chatroom");

            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          listChats()
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
