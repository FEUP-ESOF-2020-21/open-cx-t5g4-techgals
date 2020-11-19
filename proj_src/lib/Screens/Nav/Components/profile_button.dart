import 'package:flutter/material.dart';
import 'package:proj_src/Screens/Profile/screen_profile.dart';

class Profile_Button extends StatelessWidget {
  const Profile_Button({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.23,
      width: double.infinity,
      padding: EdgeInsets.only(left: 315),
      child: IconButton(
        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context){return Profile();},),);},
        icon: Icon(
          Icons.person,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
