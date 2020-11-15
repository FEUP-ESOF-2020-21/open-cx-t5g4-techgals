import 'package:flutter/material.dart';
import 'package:proj_src/BackEnd/auth.dart';
import 'package:proj_src/constants.dart';
import 'initial_aux.dart';
import 'package:proj_src/Screens/Nav/map1.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameControl = new TextEditingController();
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();

  signUpLoad() {
    if(formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods.signUp(emailControl.text, passwordControl.text).then((val){
        //print("HERE");
        Navigator.pushReplacement
          (context, MaterialPageRoute(builder: (context) {
            return Map1();
            },
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Container(
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
                      return val.length < 4 ? "invalid username (4 or more characters)" : null;
                    },
                    controller: usernameControl,
                    decoration: inputDeco("username"),
                  ),
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
                      return val.length < 6 ? "invalid password (6 or more characters)" : null;
                    },
                    obscureText: true,
                    controller: passwordControl,
                    decoration: inputDeco("password"),
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
            SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                signUpLoad();
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
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: (){
                    widget.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("Log In Now!", style: TextStyle(
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
