import 'package:flutter/material.dart';
import 'package:testchat/main.dart';
import 'package:testchat/models/user_model.dart';
import 'package:testchat/screens/message_screen.dart';
import 'package:testchat/services/navigator_service.dart';
import 'package:testchat/services/socket_service.dart';
import 'package:testchat/utils/constants.dart';
import 'package:testchat/utils/params.dart';

class FriendListScreen extends StatefulWidget {
  @override
  _FriendListScreenState createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {

  List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    _initData();

    // NotificationService(context).init();
    socketService = injector.get<SocketService>();
    socketService.createSocketConnection();
  }

  _initData() {
    for (var json in Constants.users) {
      var user = UserModel.fromMap(json);
      if (user.id != Params.currentUser.id) {
        users.add(user);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    NavigatorService(context).pushToWidget(screen: MessageScreen(chatUser: users[i],));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Text(users[i].fname, style: TextStyle(fontSize: 18.0),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 18.0,),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 24.0),
                  height: 1, width: double.infinity,
                  color: Colors.grey,
                )
              ],
            );
          }),
    );
  }
}
