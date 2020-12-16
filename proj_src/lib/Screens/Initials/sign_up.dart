import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/BackEnd/helper.dart';
import 'package:proj_src/constants.dart';
import 'initial_aux.dart';
import 'package:proj_src/Screens/Nav/map1.dart';
import 'package:proj_src/BackEnd/database.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods _authMethods = new AuthMethods();

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameControl = new TextEditingController();
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  _signUpLoad() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await _authMethods
          .signUp(usernameControl.text, emailControl.text, passwordControl.text)
          .then((val) async {
        var email = emailControl.text;
        var username = usernameControl.text;
        var pass = passwordControl.text;

        print("email: $email");
        print("username: $username");
        print("pass: $pass");

        print('HERE');
        print(val);

        if (val != null) {
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserData(emailControl.text);

          print("USERSNAP: $userInfoSnapshot");

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
                return Map1();
              },
            ),
          );
        } else {
          setState(() {
            //ERROR
            print("ERROR SIGNING UP");
            isLoading = false;
          });
        }
      });
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
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) {
                            return val.length < 4
                                ? "invalid username (4 or more characters)"
                                : null;
                          },
                          controller: usernameControl,
                          decoration: inputDeco("username"),
                          key: Key('username'),
                        ),
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
                          key: Key('email1'),
                        ),
                        TextFormField(
                          validator: (val) {
                            return val.length < 6
                                ? "invalid password (6 or more characters)"
                                : null;
                          },
                          obscureText: true,
                          controller: passwordControl,
                          decoration: inputDeco("password"),
                          key: Key('password1'),
                        ),
                      ],
                    ),
                  ),
                  /*SizedBox(height: 8,),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text("Forgot Password?"),
            ),*/
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      _signUpLoad();
                      _signUpLoad();
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
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        key: Key('signup button'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "Log In Now!",
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
