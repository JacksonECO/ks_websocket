import 'dart:convert';
import 'dart:io';

import 'package:ks_websocket/src/exception/ks_exception.dart';
import 'package:ks_websocket/src/ks_log.dart';

import '../ks_socket.dart';

class KsSocketImpl implements KsSocket {
  @override
  Socket? get socket => _socket;

  @override
  String get url => _url;

  final Socket _socket;
  final String _url;

  KsSocketImpl({
    required Socket socket,
    required String url,
  })  : _socket = socket,
        _url = url;

  static Future<KsSocketImpl> connect(
    String host,
    int port,
  ) async {
    final socket = await Socket.connect(host, port);

    return KsSocketImpl(
      socket: socket,
      url: 'ws://$host:$port',
    );
  }

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
          onData(json.decode(String.fromCharCodes(input)));
          ksLog(json.decode(String.fromCharCodes(input)), name: 'Client');
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
      _socket.add(json.encode(data).codeUnits);
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
