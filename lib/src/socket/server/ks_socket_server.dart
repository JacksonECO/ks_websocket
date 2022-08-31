import 'socket_server_action.dart';
import 'device/socket_server_none.dart' if (dart.library.io) 'device/socket_server_io.dart';

/// A library for websocket server communication.
abstract class KsSocketServer {
  SocketServerAction? getSocket(int id);

  static Future<KsSocketServer> bind(
    String address,
    int port, {
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
  }) async =>
      KSWebSocketServerImpl.bind(address, port, backlog: backlog, v6Only: v6Only, shared: shared);

  String get url;

  void listerConnection(SocketServerAction Function(SocketServerAction)? onConnection);
}
