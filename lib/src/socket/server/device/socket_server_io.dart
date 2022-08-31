import 'dart:convert';
import 'dart:io';

import 'package:ks_websocket/src/socket/server/ks_socket_server.dart';
import 'package:ks_websocket/src/socket/server/socket_server_action.dart';

class KSWebSocketServerImpl implements KsSocketServer {
  int _idCounter = 0;
  final ServerSocket _server;
  final String _url;
  final List<SocketServerAction> _clients = [];

  KSWebSocketServerImpl({
    required ServerSocket server,
    required String url,
  })  : _server = server,
        _url = url.contains('ws') ? url : 'ws://$url';

  @override
  SocketServerAction? getSocket(int id) => _clients.fold<SocketServerAction?>(null, (previousValue, client) {
        if (client.id == id) {
          return client;
        }
        return previousValue;
      });

  static Future<KsSocketServer> bind(
    String address,
    int port, {
    int backlog = 0,
    bool v6Only = false,
    bool shared = false,
  }) async {
    final server = await ServerSocket.bind(address, port, backlog: backlog, v6Only: v6Only, shared: shared);

    return KSWebSocketServerImpl(server: server, url: '$address:$port');
  }

  @override
  listerConnection(SocketServerAction Function(SocketServerAction)? onConnection) {
    if (onConnection == null) return;
    _server.listen((socket) {
      final action = onConnection(SocketServerAction<Socket>(id: _idCounter++, socket: socket));
      _clients.add(action);

      if (action.onConnection != null) action.onConnection!(action);

      if (action.listerMessageUint8List != null) {
        socket.listen(
          (data) {
            action.listerMessageUint8List!(action, data);
          },
          onDone: () {
            if (action.onClose != null) {
              action.onClose!(action);
            }
          },
        );
      }
      if (action.listerMessage != null) {
        socket.listen(
          (data) {
            try {
              action.listerMessage!(action, json.decode(String.fromCharCodes(data)));
            } catch (e) {
              print(String.fromCharCodes(data));
            }
          },
          onDone: () {
            if (action.onClose != null) {
              action.onClose!(action);
            }
          },
        );
      }
    });
  }

  @override
  String get url => _url;
}
