import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:testchat/screens/sign_screen.dart';
import 'package:testchat/services/inject_service.dart';
import 'package:testchat/services/socket_service.dart';

Injector injector;
SocketService socketService;

Future<void> main() async {
  InjectionService().initialise(Injector.getInjector());
  injector = Injector.getInjector();
  if (injector != null) await AppInitializer().initialise(injector);

  runApp(MyApp());
}

class AppInitializer {
  initialise(Injector injector) async {}
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignScreen(),
    );
  }
}
