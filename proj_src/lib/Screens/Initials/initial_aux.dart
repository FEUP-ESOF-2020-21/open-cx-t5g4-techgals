import 'package:flutter/material.dart';
import 'package:proj_src/constants.dart';
import 'package:proj_src/Screens/Initials/log_in.dart';
import 'package:proj_src/Screens/Initials/sign_up.dart';

InputDecoration inputDeco(String hintText) {
  return InputDecoration(
    hintText: hintText,
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryColor)
    ),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kPrimaryLightColor)
    ),
  );
}

// ignore: must_be_immutable
class Authenticate extends StatefulWidget {

  bool login;
  Authenticate(this.login);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  void toggleViews() {
    setState(() {
      widget.login =! widget.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.login) {
      return LogIn(toggleViews);
    } else {
      return SignUp(toggleViews);
    }
  }
}
