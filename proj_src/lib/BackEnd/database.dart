import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUsername(String username) async {
    return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username ).get();
  }

  getChatByName(String name) async{
    return await FirebaseFirestore.instance.collection("chats").where("name", isEqualTo: name ).get();
  }

  getActiveChat() async {
    var chatNames = <String>[];
/*
    var docs = await Firestore.instance
        .collection('myCollection')
        .snapshots()
        .documents((snapshot);
        docs.forEach((doc) => this.total += doc.data['amount']));
*/

    return chatNames;
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
  
  getChatsMessages(String chatID, int index) {
    return FirebaseFirestore.instance.collection('chats').doc(chatID).collection('messages').orderBy('time').snapshots();
  }
}