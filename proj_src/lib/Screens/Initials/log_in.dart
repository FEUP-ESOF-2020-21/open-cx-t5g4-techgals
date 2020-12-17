import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/Screens/Nav/navigation.dart';
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

  _logInLoad() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authMethods
          .logIn(emailControl.text, passwordControl.text)
          .then((val) async {
        if (val != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserData(emailControl.text);

          await HelperFunctions.saveUserLoggedInSharedPreference(true);
          await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
            print("Logged in: $value");
          });

          await HelperFunctions.saveUserEmailSharedPreference(
              emailControl.text);
          await HelperFunctions.getUserEmailSharedPreference().then((value) {
            print("Email: $value");
          });

          await HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0].data()['username']);
          await HelperFunctions.getUserNameSharedPreference().then((value) {
            print("Username: $value");
          });

          print("Signed In");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NavigationMap();
              },
            ),
          );
        } else {
          setState(() {
            print("ERROR LOGGING IN");
            isLoading = false;
          });
        }
      });
    }
  }

  resetPassLoad() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.resetPass(emailControl.text).then((val) {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/logoWhite.PNG",
                    height: 85,
                    width: 350,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val)
                                ? null
                                : "invalid email";
                          },
                          controller: emailControl,
                          decoration: inputDeco("email"),
                          key: Key('email'),
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.length < 6 ? "invalid password" : null;
                          },
                          obscureText: true,
                          controller: passwordControl,
                          decoration: inputDeco("password"),
                          key: Key('password'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /*  GestureDetector(
              onTap: (){
                resetPassLoad();
              },
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text("Forgot Password?"),
              ),
            ),*/
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    key: Key('loginbtn'),
                    onTap: () {
                      _logInLoad();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          kPrimaryColor,
                          kPrimaryLightColor,
                        ]),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        "LOG IN",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account yet? "),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Sign Up Now!",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  )
                ],
              ),
            ),
    );
  }
}
