import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_src/BackEnd/UserClass.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/BackEnd/helper.dart';

class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserClass _userFromFirebase(User user) {
    return user != null ? UserClass(userID: user.uid) : null;
  }

  Future logIn(String email, String password) async {
    print(0);
    try{
      print(1);
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(2);
      User firebaseUser = result.user;
      print('RESULT: $result');
      print('USER: $firebaseUser');
      print(_userFromFirebase(firebaseUser));
      return _userFromFirebase(firebaseUser);
    } catch(error) {
        print(error.toString());
    }
  }

  Future signUp(String username, String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;

      // create a new document for the user with uid
      await DatabaseMethods(uid: firebaseUser.uid).updateUserData(username, email, []);

      return _userFromFirebase(firebaseUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInSharedPreference(false);
      await HelperFunctions.saveUserEmailSharedPreference('');
      await HelperFunctions.saveUserNameSharedPreference('');

      return await _auth.signOut().whenComplete(() async {
        print("Logged out");
        await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
          print("Logged in: $value");
        });
        await HelperFunctions.getUserEmailSharedPreference().then((value) {
          print("Email: $value");
        });
        await HelperFunctions.getUserNameSharedPreference().then((value) {
          print("Username: $value");
        });
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }



}