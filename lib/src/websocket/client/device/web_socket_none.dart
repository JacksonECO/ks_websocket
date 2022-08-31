import 'package:ks_websocket/src/exception/ks_exception.dart';

import '../ks_websocket.dart';

class KsWebSocketImpl implements KsWebSocket {
  @override
  Future<void> close() {
    throw PlatformNotSupportedException;
  }

  @override
  bool get isWeb => throw PlatformNotSupportedException;

  @override
  void send(data) {
    throw PlatformNotSupportedException;
  }

  static Future<KsWebSocket> connect(String url) {
    throw PlatformNotSupportedException;
  }

  @override
  void write(message) {
    throw PlatformNotSupportedException;
  }

  @override
  get socket => throw PlatformNotSupportedException;

  @override
  String get url => throw PlatformNotSupportedException;

  @override
  void listen(void Function(dynamic message) onData, [bool decodeJson = true]) {
    throw PlatformNotSupportedException;
  }
}
