import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  final String uid;
  DatabaseMethods({
    this.uid
  });

  // Collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference chatCollection = FirebaseFirestore.instance.collection('chats');


  // update userdata
  Future updateUserData(String username, String email, List<String> interests/*, String password*/) async {
    return await userCollection.doc(uid).set({
      'username': username,
      'email': email,
      //'password': password,
      //'groups' : [],
      'interests': interests,
      //'profilePic': ''
    });
  }

  Future updateEmail(String email) async {
    return await userCollection.doc(uid).update({
      'email': email,
    });
  }

  // create chat
  Future createChatRoom(String username, String chatName) async {
    DocumentReference chatDocRef = await chatCollection.add({
      'name': chatName,
      'admin': username,
      'participants': [],
      'muted': [],
      'recentMessage': '',
      'recentMessageSender': '',
      'recentMessageTime': ''
    });

    await chatDocRef.update({
      'participants': FieldValue.arrayUnion([username]),
    });
  }

  Future deleteChatRoom(String docID) async{
    return await chatCollection.doc(docID).delete();
  }

  // add interest
  Future addInterest(String interest) async {
    return await userCollection.doc(uid).update({
      'interests': FieldValue.arrayUnion([interest]),
    });
  }

  // remove interest
  Future removeInterest(String interest) async {
    return await userCollection.doc(uid).update({
      'interests': FieldValue.arrayRemove([interest])
    });
  }

  // update chatRoom data
  Future updateChatInfo(String chatID, String username, bool add) async {
    return add ?
        await chatCollection.doc(chatID).update({
          'participants': FieldValue.arrayUnion([username])
        })
        :
        await chatCollection.doc(chatID).update({
          'participants': FieldValue.arrayRemove([username])
        })
    ;
  }

  // mute user
  Future muteUser(String chatID, String username) async {
    return await chatCollection.doc(chatID).update({
      'muted': FieldValue.arrayUnion([username])
      });
  }



  // get user data from username
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  // send message
  sendMessage(String chatID, chatMessageData) {
    chatCollection.doc(chatID).collection('messages').add(chatMessageData);
    chatCollection.doc(chatID).update({
      'recentMessage': chatMessageData['message'],
      'recentMessageSender': chatMessageData['sender'],
      'recentMessageTime': chatMessageData['time'].toString(),
    });
  }

  // get chats of a particular group
  getChats(String chatID) async {
    return chatCollection.doc(chatID).collection('messages').orderBy('time').snapshots();
  }

  // returns every chat room
  getActiveChats() async {
    return chatCollection.snapshots();
  }

  emailTaken(String email) async {
    QuerySnapshot querySnapshot = await userCollection.where('email', isEqualTo: email).get();
    return querySnapshot;
  }

  getUser(String username) async{
    QuerySnapshot snapshot = await userCollection.where('username', isEqualTo: username).get();
    return snapshot;
  }

  getChat(String chatname) async {
    QuerySnapshot snapshot = await chatCollection.where('name', isEqualTo: chatname).get();
    return snapshot;
  }

}