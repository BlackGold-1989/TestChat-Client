import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:testchat/services/socket_service.dart';

class InjectionService {
  Injector initialise(Injector injector) {
    injector.map<SocketService>((i) => SocketService(), isSingleton: true);
    return injector;
  }
}
