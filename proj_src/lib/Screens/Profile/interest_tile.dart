import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Initials/initial_aux.dart';
import 'package:proj_src/constants.dart';

class InterestTile extends StatelessWidget {

  final String message;

  InterestTile({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.centerLeft,
        width: MediaQuery.of(context).size.width,
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
              Text(message, style: TextStyle(fontSize: 17.0, color: Colors.white)),
              GestureDetector(
                onTap: () {
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
