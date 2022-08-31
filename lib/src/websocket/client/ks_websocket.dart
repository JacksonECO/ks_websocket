// ignore: unused_import
import 'device/web_socket_none.dart'
    if (dart.library.io) 'device/web_socket_io.dart'
    if (dart.library.html) 'device/web_socket_html.dart';

/// A library for websocket communication.
abstract class KsWebSocket {
  /// Indicates whether the connection is web or not.
  bool get isWeb;

  /// Connection address
  String get url;

  /// Object socket utility for communication.\
  /// For implementation advanced.
  dynamic get socket;

  /// Create a new WebSocket connection. The URL supplied in [url]\
  /// must use the scheme `ws` or `wss`.
  static Future<KsWebSocket> connect(String url) => KsWebSocketImpl.connect(url);

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
