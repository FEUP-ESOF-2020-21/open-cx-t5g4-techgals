import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proj_src/BackEnd/database.dart';
import 'package:proj_src/Screens/Chatroom/manageChat.dart';
import 'package:proj_src/Screens/Chatroom/message_tile.dart';

class ChatPage extends StatefulWidget {

  final String groupId;
  final String userName;
  final String groupName;

  ChatPage({
    this.groupId,
    this.userName,
    this.groupName
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Stream<QuerySnapshot> _chats;
  TextEditingController messageEditingController = new TextEditingController();
  bool isAdmin = false;
  bool inChat = true;

  @override
  void initState() {
    super.initState();
    DatabaseMethods().getChats(widget.groupId).then((val) {
      setState(() {
        _chats = val;
      });
    });
    _checkAdmin();
    print('is chat admin: $isAdmin');
    print('in chat: $inChat');
  }

  _checkinChat() async {
    QuerySnapshot _chatQS;
    await DatabaseMethods().getChat(widget.groupName).then((value) {
      setState(() {
        _chatQS = value;
      });
    });
    List<String> _participants;
    for(var i = 0; i< _chatQS.docs[0].get('participants').length; i++) {
      _participants.add(_chatQS.docs[0].get('participants')[i]);
    }
    _participants.forEach((element) {element.toLowerCase();});
    print("CHECKING IN CHAT");
    print(_participants.contains(widget.userName));
    if(_participants.contains(widget.userName)) inChat = true;
    else inChat = false;
  }

  _checkAdmin() async {
    QuerySnapshot _chatQS;
    await DatabaseMethods().getChat(widget.groupName).then((value) {
      setState(() {
        _chatQS = value;
      });
    });

    if(_chatQS.docs[0].get('admin') == widget.userName) isAdmin = true;
  }

  Widget _chatMessages(){
    return StreamBuilder(
      stream: _chats,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){
            return MessageTile(
              message: snapshot.data.documents[index]['message'],
              sender: snapshot.data.documents[index]['sender'],
              sentByMe: (widget.userName == snapshot.data.documents[index]['sender']),
            );
          },
          scrollDirection: Axis.vertical,
        )
            :
        Container();
      },
    );
  }
  _sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sender": widget.userName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().sendMessage(widget.groupId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  DatabaseMethods().updateChatInfo(widget.groupId, widget.userName, false);
                  Navigator.pop(context);
                }
            );
          },
        ),
        actions: <Widget>[
          isAdmin ?
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) { return ManageChat(chatName: widget.groupName, groupId: widget.groupId, userName: widget.userName,);},),);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.account_circle),
            ),
          )
              : Container()
          ,
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            _chatMessages(),
            // Container(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                color: Colors.grey[700],
                child:
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageEditingController,
                        style: TextStyle(
                            color: Colors.white
                        ),
                        decoration: InputDecoration(
                            hintText: "Send a message ...",
                            hintStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 16,
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),

                    SizedBox(width: 12.0),
                    GestureDetector(
                      onTap: () {
                        print("before check");
                        _checkinChat();
                        print("after check");
                        if(inChat) _sendMessage();
                        else _popup(context);
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Center(child: Icon(Icons.send, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _popup(BuildContext context) {
    Widget exitButton = FlatButton(
      child: Text("exit"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("You've been expelled from the chat!\n     You can no longer send messages..."),
      content: Text("..."),
      actions: [
        exitButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
