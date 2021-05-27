import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:testchat/services/notification_service.dart';
import 'package:testchat/utils/params.dart';

const String SOCKET = 'ws://192.168.1.5:8222';

class SocketService {
  IO.Socket socket;

  createSocketConnection() {
    socket = IO.io(SOCKET, <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.connect();

    socket.onConnect((_) async {
      print('socket connected');

      var paramSelf = {
        'userid': 'user${Params.currentUser.id}',
        'username': Params.currentUser.fname,
      };
      socket.emit('self', paramSelf);

      this.socket.on("unread", (value) async {
        print("[receiver] unread ===> ${value.toString()}");
        NotificationService.showNotification('Message', '${value['username']}\n${value['text']}', NotificationService.keyMessageChannel);
      });
    });

    this.socket.on("disconnect", (_) => print('Disconnected'));
  }

  void sendChat(String roomId, String userid, String msg) {
    var param = {
      'roomid': 'room$roomId',
      'senderid': 'user${Params.currentUser.id}',
      'username': Params.currentUser.fname,
      'receiverid': 'user$userid',
      'msg': msg,
      'timestamp' : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now().toUtc())
    };
    print('[send] send message ===> ${param.toString()}');
    socket.emit('chatMessage', param);
  }

  void leaveRoom() {
    var param = {
      'roomid': 'room1',
      'userid' : 'user${Params.currentUser.id}'
    };
    socket.emit('leaveRoom', param);
  }

  void joinRoom({
    @required String roomId,
    @required Function(dynamic) message,
    @required Function(dynamic) leaveRoom,
    @required Function(dynamic) joinChat,
  }) {
    var param = {
      'userid': 'user${Params.currentUser.id}',
      'username': Params.currentUser.fname,
      'roomid': 'room$roomId',
    };
    socket.emit('joinRoom', param);

    this.socket.on("message", (value) async {
      print("[receiver] message receiver ===> ${value.toString()}");
      message(value);
    });
  }
}
