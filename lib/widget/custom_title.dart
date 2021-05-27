import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;

  CustomTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: Theme.of(context).highlightColor,
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      alignment: Alignment.center,
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
