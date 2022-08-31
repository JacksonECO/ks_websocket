import 'dart:convert';
import 'dart:html';

import 'package:ks_websocket/src/exception/ks_exception.dart';
import 'package:ks_websocket/src/ks_log.dart';

import '../ks_websocket.dart';

class KsWebSocketImpl implements KsWebSocket {
  late final WebSocket _socket;
  late final String _url;

  KsWebSocketImpl({
    required WebSocket socket,
    required String url,
  })  : _socket = socket,
        _url = url;

  static Future<KsWebSocket> connect(String url) async {
    final socket = WebSocket(url);
    await socket.onOpen.first.timeout(const Duration(seconds: 10));

    return KsWebSocketImpl(
      socket: socket,
      url: url,
    );
  }

  @override
  Future<void> close() async {
    socket.close();
    ksLog('Close connection', name: 'Client');
  }

  @override
  void listen(void Function(dynamic message) onData, [bool decodeJson = true]) {
    socket.onMessage.listen(
      (MessageEvent event) {
        if (decodeJson) {
          onData(json.decode(event.data));
          ksLog(json.decode(event.data), name: 'Client');
        } else {
          onData(event.data);
          ksLog(event.data, name: 'Client');
        }
      },
      onDone: close,
      onError: (error) => throw error,
    );
  }

  @override
  void send(Object data) {
    try {
      _socket.send(json.encode(data));
      ksLog(json.encode(data), name: 'Client');
    } on StateError catch (e) {
      _stateError(e);
      rethrow;
    }
  }

  @override
  void write(message) {
    try {
      _socket.send(message);
      ksLog(message, name: 'Client');
    } on StateError catch (e) {
      _stateError(e);
      rethrow;
    }
  }

  @override
  WebSocket get socket => _socket;

  @override
  bool get isWeb => true;

  @override
  String get url => _url;

  void _stateError(StateError e) {
    if (e.message == 'StreamSink is closed') {
      throw ConnectionIsCloseException;
    }
  }
}
