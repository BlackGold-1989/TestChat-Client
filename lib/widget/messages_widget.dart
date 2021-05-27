import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:testchat/widget/custom_title.dart';


class MessageWidget extends StatelessWidget {
  const MessageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitle(title: 'Messages'),
        SizedBox(height: 10),
        Text(
          'New Matches',
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 1,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      'P',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Preference'.length < 10
                        ? 'Preference'
                        : 'Preference'.substring(0, 10),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => Dismissible(
              key: ValueKey(index),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  print('Deleetd');
                }
              },
              background: Container(
                color: Theme.of(context).errorColor,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  MdiIcons.blockHelper,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
              ),
              child: BuildChatMessageHolder(),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildChatMessageHolder extends StatelessWidget {
  const BuildChatMessageHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Theme.of(context).primaryColor,
          height: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListTile(
            title: Text('Preference Team'),
            subtitle: Text(
              'Welcome to Preference Dating App',
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '3 min ago',
                  style: TextStyle(fontSize: 10),
                ),
                SizedBox(height: 5),
                Icon(
                  MdiIcons.checkboxBlankCircle,
                  color: Theme.of(context).errorColor,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          height: 0,
        ),
      ],
    );
  }
}
