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

  // create chat
  Future createChatRoom(String username, String chatName) async {
    DocumentReference chatDocRef = await chatCollection.add({
      'name': chatName,
      'admin': username,
      'participants': [],
      //'messages': ,
      //'chatId': '',
      'recentMessage': '',
      'recentMessageSender': '',
      'recentMessageTime': ''
    });

    await chatDocRef.update({
      'participants': FieldValue.arrayUnion([username]),
      //'chatId': chatDocRef.id
    });
    /*
    DocumentReference userDocRef = userCollection.doc(uid);
    return await userDocRef.update({
      'groups': FieldValue.arrayUnion([chatDocRef.id + '_' + chatName])
    }); */
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



  // get user data from username
  Future getUserData(String email) async {
    QuerySnapshot snapshot = await userCollection.where('email', isEqualTo: email).get();
    //print(snapshot.docs[0].data);
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

  getUserInterests(String userID) async {
    return userCollection.doc(userID).snapshots();
  }

  // returns every chat room
  getActiveChats() async {
    return chatCollection.snapshots();
  }

  usernameTaken(String username) async {
    QuerySnapshot querySnapshot = await userCollection.where('username', isEqualTo: username).get();
    print(querySnapshot.size);
    return null;
  }

  emailTaken(String email) async {
    QuerySnapshot querySnapshot = await userCollection.where('email', isEqualTo: email).get();
    print(querySnapshot.size);
    return null;
  }

  getUsers() async {
    return userCollection.snapshots();
  }

  getUser(String username) async{
    QuerySnapshot snapshot = await userCollection.where('username', isEqualTo: username).get();
    return snapshot;
  }

  getChat(String chatname) async {
    QuerySnapshot snapshot = await chatCollection.where('name', isEqualTo: chatname).get();
    return snapshot;
  }

/*-----------------------------------------------------------------------------------------------*/

  getChatByName(String name) async{
    return await FirebaseFirestore.instance.collection("chats").where("name", isEqualTo: name ).get();
  }

  uploadUserInfo(String name, String email, List<String> interest){

    FirebaseFirestore.instance.collection("users").add({
      'username': name,
      'email': email,
      'interests': interest
    });

  }

}