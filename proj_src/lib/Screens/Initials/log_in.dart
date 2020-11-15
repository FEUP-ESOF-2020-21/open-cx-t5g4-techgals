import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/Screens/Nav/map1.dart';
import 'package:proj_src/constants.dart';
import 'initial_aux.dart';

class LogIn extends StatefulWidget {

  final Function toggle;
  LogIn(this.toggle);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  logInLoad() {
    if(formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.logIn(emailControl.text, passwordControl.text).then((val){
        //print("HERE");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Map1();},),);
      });
    }
  }

  resetPassLoad(){
    if(formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.resetPass(emailControl.text).then((val){
        print("HERE");
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)
                          ? null : "invalid email" ;
                    },
                    controller: emailControl,
                    decoration: inputDeco("email"),
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.length < 6 ? "invalid password" : null;
                    },
                    obscureText: true,
                    controller: passwordControl,
                    decoration: inputDeco("password"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
            GestureDetector(
              onTap: (){
                resetPassLoad();
              },
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text("Forgot Password?"),
              ),
            ),
            SizedBox(height: 16,),
            GestureDetector(
              onTap: (){
                logInLoad();
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
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account yet? "),
                GestureDetector(
                  onTap: (){
                    widget.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Sign Up Now!", style: TextStyle(
                      decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 75,)
          ],
        ),
      ),
    );
  }
}
