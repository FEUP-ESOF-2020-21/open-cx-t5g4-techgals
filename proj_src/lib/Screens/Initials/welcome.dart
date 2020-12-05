import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/constants.dart';
import 'initial_aux.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /*Text("WELCOME"),
            SizedBox(height: 50,),*/
            Image.asset("assets/images/logoWhite.PNG", height: 85, width: 350,),
            SizedBox(height: 250,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return Authenticate(true); },));
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        kPrimaryColor,
                        kPrimaryLightColor,
                      ]
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text("LOG IN", style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) { return Authenticate(false); },));
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        kPrimaryColor,
                        kPrimaryLightColor,
                      ]
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text("SIGN UP", style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                ),
              ),
            ),
            SizedBox(height: 75,)
          ],
        ),
      ),
    );
  }
}

