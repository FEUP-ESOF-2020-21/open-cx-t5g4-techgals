import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/Screens/Nav/Components/appBar.dart';
import 'package:proj_src/Screens/Nav/Components/interestsUser.dart';
import '../../constants.dart';

class NetworkingPage extends StatefulWidget {

  final String userName;
  NetworkingPage({this.userName});

  @override
  _NetworkingPageState createState() => _NetworkingPageState();
}

class _NetworkingPageState extends State<NetworkingPage> {

  User _user = FirebaseAuth.instance.currentUser;
  List<String> _interests = [];
  List<UserInt> _usersWithSimilarInterests = [];

  @override
  void initState() {
    super.initState();
    _getInterests();
  }

  _getInterests() async {
    QuerySnapshot _userQS;
    await DatabaseMethods().getUser(widget.userName).then((value) {
      setState(() {
        _userQS = value;
      });
    });
    _interests.clear();
    for(var i = 0; i< _userQS.docs[0].get('interests').length; i++) {
      _interests.add(_userQS.docs[0].get('interests')[i]);
    }
    _interests.forEach((element) {element.toLowerCase();});
    print(_interests);
    _getUsersWithSimilarInterests();
  }
  _getUsersWithSimilarInterests() async{
    QuerySnapshot _userQS;
    _usersWithSimilarInterests.clear();

    await DatabaseMethods().usersWithInterests(_interests).then((value) {
      setState(() {
        _userQS = value;
      });
    });

    for(var j = 0; j< _userQS.size; j++) {
      if(_userQS.docs[j].get('username') != widget.userName) {
        String un = _userQS.docs[j].get('username');
        String email = _userQS.docs[j].get('email');
        List<String> inte = [];
        for(var k = 0; k<_userQS.docs[j].get('interests').length; k++) {
          inte.add(_userQS.docs[j].get('interests')[k]);
        }
        inte.removeWhere((item) => !_interests.contains(item));
        _usersWithSimilarInterests.add(
            new UserInt(
                username: un,
                email: email,
                commonInterests: inte,
        ));
      }
    }
    print(_usersWithSimilarInterests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar_Networking(context),
      body: Container(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Stack(
              children: <Widget> [
                _usersList(),
              ],
            )
        ),
      ),
    );
  }

  Widget _usersList() {
    return ListView.builder(
      itemCount: (_usersWithSimilarInterests.length + 2),//snapshot.data.documents.length,
      itemBuilder: (context, index){
        if(index == 0) {
          return Text(
            'Users With Similar Interests',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          );
        }
        else if(index == 1) { return Divider(height: 30,); }
        else return _userTile(_usersWithSimilarInterests[index-2]);
      },
      scrollDirection: Axis.vertical,
    );
  }
  Widget _userTile(UserInt user) {
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
              Text(user.getUsername().toLowerCase(), style: TextStyle(fontSize: 17.0, color: Colors.white)),
              Text(user.getEmail().toLowerCase(), style: TextStyle(fontSize: 17, color: Colors.white),),
              //Text(user.getList().toString(),)
            ],
          ),
        ),
      ),
    );
  }

}
