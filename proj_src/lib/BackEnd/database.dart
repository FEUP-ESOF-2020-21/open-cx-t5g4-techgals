import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods{

  final String uid;
  DatabaseMethods({
    this.uid
  });

  // Collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference chatCollection = FirebaseFirestore.instance.collection('chats');

  // update userdata
  Future updateUserData(String username, String email, String password) async {
    return await userCollection.doc(uid).set({
      'username': username,
      'email': email,
      'password': password,
      'groups' : [],
      'interests': [],
      'profilePic': ''
    });
  }

  // create chat
  Future createChatRoom(String username, String chatName) async {
    DocumentReference chatDocRef = await chatCollection.add({
      'chatName': chatName,
      'admin': username,
      'members': [],
      //'messages': ,
      'chatId': '',
      'recentMessage': '',
      'recentMessageSender': ''
    });

    await chatDocRef.update({
      'members': FieldValue.arrayUnion([uid + '_' + username]),
      'chatId': chatDocRef.id
    });

    DocumentReference userDocRef = userCollection.doc(uid);
    return await userDocRef.update({
      'groups': FieldValue.arrayUnion([chatDocRef.id + '_' + chatName])
    });
  }

  // toggling the user group join
  Future togglingGroupJoin(String groupId, String chatName, String userName) async {

    DocumentReference userDocRef = userCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference groupDocRef = chatCollection.doc(groupId);

    List<dynamic> groups = await userDocSnapshot.get('groups');
    //List<dynamic> groups = await userDocSnapshot.data['groups'];

    if(groups.contains(groupId + '_' + chatName)) {
      //print('hey');
      await userDocRef.update({
        'groups': FieldValue.arrayRemove([groupId + '_' + chatName])
      });

      await groupDocRef.update({
        'members': FieldValue.arrayRemove([uid + '_' + userName])
      });
    }
    else {
      //print('nay');
      await userDocRef.update({
        'groups': FieldValue.arrayUnion([groupId + '_' + chatName])
      });

      await groupDocRef.update({
        'members': FieldValue.arrayUnion([uid + '_' + userName])
      });
    }
  }

  // get user data from username
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    //print(snapshot.docs[0].data);
    return snapshot;
  }

/*  // get users
  getUserGroups() async {
    return FirebaseFirestore.instance.collection("users").doc(uid).snapshots();
  }*/

  // send message
  sendMessage(String chatID, chatMessageData) {
    FirebaseFirestore.instance.collection('chats').doc(chatID).collection('messages').add(chatMessageData);
    FirebaseFirestore.instance.collection('chats').doc(chatID).update({
      'recentMessage': chatMessageData['message'],
      'recentMessageSender': chatMessageData['sender'],
      'recentMessageTime': chatMessageData['time'].toString(),
    });
  }

  // get chats of a particular group
  getChats(String chatID) async {
    return FirebaseFirestore.instance.collection('chats').doc(chatID).collection('messages').orderBy('time').snapshots();
  }

  getChatsNames() async {
    List<String> result = [];
    await FirebaseFirestore.instance.collection('chats').get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        result.add(element.get('name'));
      });
    });
    return result;
  }

  getActiveChats() async {
    return FirebaseFirestore.instance.collection('chats').snapshots();
  }

  getNumberOfChats() async {
    await chatCollection.get().then((snap) {
      return snap.size; // will return the collection size
    });
  }

/*-----------------------------------------------------------------------------------------------*/

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username ).get();
  }

  getChatByName(String name) async{
    return await FirebaseFirestore.instance.collection("chats").where("name", isEqualTo: name ).get();
  }


  getChatsCollection() {
    return FirebaseFirestore.instance.collection("chats");
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChat(String chatID, chatMap){
    FirebaseFirestore.instance.collection("chats")
        .doc(chatID).set(chatMap);
  }


}