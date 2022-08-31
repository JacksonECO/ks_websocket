import 'package:ks_websocket/ks_websocket.dart';
import 'package:ks_websocket/src/socket/server/socket_server_action.dart';

class KSWebSocketServerImpl implements KsSocketServer {
  static Future<KsSocketServer> bind(
    String address,
    int port, {
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
  }) async {
    throw PlatformNotSupportedException();
  }

  @override
  SocketServerAction? getSocket(int id) {
    throw PlatformNotSupportedException();
  }

  @override
  listerConnection(SocketServerAction Function(SocketServerAction p1)? onConnection) {
    throw PlatformNotSupportedException();
  }

  @override
  String get url => throw PlatformNotSupportedException();
}
