import 'device/socket_none.dart' if (dart.library.io) 'device/socket_io.dart';

/// A library for websocket communication.
abstract class KsSocket {
  /// Connection address
  String get url;

  /// Object socket utility for communication.\
  /// For implementation advanced.
  dynamic get socket;

  /// Create a new WebSocket connection. The URL supplied in [host] and [port]
  static Future<KsSocketImpl> connect(
    String host,
    int port,
  ) =>
      KsSocketImpl.connect(host, port);

  /// On each data event from this stream, the subscriber's [onData] handler is called
  void listen(void Function(dynamic message) onData, [bool decodeJson = true]);

  /// Close this WebSocket connection.
  Future<void> close();

  /// Send message to server.\
  /// Convert `Object` to `json` and send.
  void send(Object data);

  /// Send message to server (no conversion).\
  /// message is `String` or `List<int>`
  void write(dynamic message);
}
