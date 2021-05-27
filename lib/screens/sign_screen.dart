import 'package:flutter/material.dart';
import 'package:testchat/models/user_model.dart';
import 'package:testchat/screens/friend_list_screen.dart';
import 'package:testchat/services/navigator_service.dart';
import 'package:testchat/services/notification_service.dart';
import 'package:testchat/utils/constants.dart';
import 'package:testchat/utils/params.dart';
import 'package:testchat/widget/button_widget.dart';

class SignScreen extends StatefulWidget {
  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  var controller = TextEditingController();
  var isEnabled = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      var userid = controller.text;
      setState(() {
        if (userid == '1' || userid == '2') {
          isEnabled = true;
        } else {
          isEnabled = false;
        }
      });
    });

    NotificationService(context).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'User ID'
              ),
            ),
          ),
          SizedBox(height: 16.0,),
          Text('You can choose 1 or 2 for login.'),
          SizedBox(height: 24.0,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: FullWidthButton(
              title: 'Login',
              action: isEnabled? () => _gotoLogin() : null,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  _gotoLogin() {
    var userid = controller.text;
    for (var json in Constants.users) {
      var user = UserModel.fromMap(json);
      if (user.id == int.parse(userid)) {
        Params.currentUser = user;
      }
    }
    NavigatorService(context).pushToWidget(screen: FriendListScreen());
  }
}
