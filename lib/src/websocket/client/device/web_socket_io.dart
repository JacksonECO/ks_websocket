import 'dart:convert';
import 'dart:io';

import 'package:ks_websocket/src/exception/ks_exception.dart';
import 'package:ks_websocket/src/ks_log.dart';

import '../ks_websocket.dart';

class KsWebSocketImpl implements KsWebSocket {
  final WebSocket _socket;
  final String _url;

  KsWebSocketImpl({
    required WebSocket socket,
    required String url,
  })  : _socket = socket,
        _url = url;

  static Future<KsWebSocket> connect(String url) async {
    final socket = await WebSocket.connect(url);

    return KsWebSocketImpl(
      socket: socket,
      url: url,
    );
  }

  @override
  bool get isWeb => false;

  @override
  WebSocket? get socket => _socket;

  @override
  String get url => _url;

  @override
  Future<void> close() async {
    await _socket.close();
    ksLog('Close connection', name: 'Client');
  }

  @override
  void listen(void Function(dynamic message) onData, [bool decodeJson = true]) {
    _socket.listen(
      (input) {
        if (decodeJson) {
          onData(json.decode(input));
          ksLog(json.decode(input), name: 'Client');
        } else {
          onData(input);
          ksLog(input, name: 'Client');
        }
      },
      onDone: close,
      onError: (error) => throw error,
    );
  }

  @override
  void send(Object data) {
    try {
      _socket.add(json.encode(data));
      ksLog(json.encode(data), name: 'Client');
    } on StateError catch (e) {
      _stateError(e);
      rethrow;
    }
  }

  @override
  void write(dynamic data) {
    try {
      _socket.add(data);
      ksLog(data, name: 'Client');
    } on StateError catch (e) {
      _stateError(e);
      rethrow;
    }
  }

  void _stateError(StateError e) {
    if (e.message == 'StreamSink is closed') {
      throw ConnectionIsCloseException;
    }
  }
}
