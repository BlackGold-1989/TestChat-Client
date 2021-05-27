import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testchat/main.dart';
import 'package:testchat/models/message_model.dart';
import 'package:testchat/models/user_model.dart';
import 'package:testchat/services/string_service.dart';
import 'package:testchat/utils/params.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  final UserModel chatUser;

  const MessageScreen({Key key, this.chatUser}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  StreamController<List<dynamic>> messageController = StreamController.broadcast();

  List<MessageModel> messages = [];
  var controller = TextEditingController();
  var isEnabled = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        isEnabled = controller.text.isNotEmpty;
      });
    });

    messageController.add(messages);

    socketService.joinRoom(
      roomId: '1',
      message: _receivedMsg,
      leaveRoom: _leaveRoom,
      joinChat: _joinChat,
    );
  }

  _leaveRoom(dynamic value) {

  }

  _joinChat(dynamic value) {

  }

  _receivedMsg(dynamic value) {
    MessageModel model = MessageModel(
      id: messages.length,
      userid: value['id'],
      msg: value['text'],
      regdate: value['time'],
    );
    if (model.userid == 'user${Params.currentUser.id}') return;
    messages.insert(0, model);
    messageController.add(messages);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.fname),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: StreamBuilder(
              stream: messageController.stream,
              builder: (context, snapshot) {
                return snapshot.data == null? Container()
                    : ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, i) {
                      var sender = messages[i].userid == 'user${Params.currentUser.id}';
                      return !sender? Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 8.0, left: 8.0),
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(4.0))
                            ),
                            child: Column(
                              children: [
                                Text(messages[i].msg, style: TextStyle(color: Colors.white),),
                                Text(StringService.getChatTime(messages[i].regdate), style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ) : Container(
                        padding: EdgeInsets.only(top: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.all(Radius.circular(4.0))
                              ),
                              child: Column(
                                children: [
                                  Text(messages[i].msg, style: TextStyle(color: Colors.white)),
                                  Text(StringService.getChatTime(messages[i].regdate), style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
            )),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              width: double.infinity, height: 1, color: Colors.grey,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Message'
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0,),
                  InkWell(
                    onTap: () {
                      if (isEnabled) {
                        send(controller.text);
                      }
                    },
                      child: Icon(Icons.send, color: Colors.blue,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  send(String message) {
    var msg = MessageModel(
      id: messages.length,
      userid: 'user${Params.currentUser.id}',
      msg: message,
      regdate: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc()),
    );
    setState(() {
      messages.insert(0, msg);
      controller.text = '';
    });
    messageController.add(messages);
    socketService.sendChat('1', '${widget.chatUser.id}', message);
  }

  @override
  void dispose() {
    socketService.leaveRoom();
    super.dispose();
  }

}
