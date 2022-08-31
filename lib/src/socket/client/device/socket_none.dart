import 'package:ks_websocket/src/exception/ks_exception.dart';

import '../ks_socket.dart';

class KsSocketImpl implements KsSocket {
  @override
  Future<void> close() {
    throw PlatformNotSupportedException;
  }

  @override
  void send(data) {
    throw PlatformNotSupportedException;
  }

  static Future<KsSocketImpl> connect(
    String host,
    int port,
  ) {
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
