import 'dart:typed_data';

class SocketServerAction<T> {
  final int id;
  final T socket;
  final Map? info;
  final void Function(SocketServerAction)? onClose;
  final void Function(SocketServerAction)? onConnection;
  final void Function(SocketServerAction, dynamic message)? listerMessage;
  final void Function(SocketServerAction, Uint8List message)? listerMessageUint8List;

  SocketServerAction({
    required this.id,
    required this.socket,
    this.info,
    this.onClose,
    this.onConnection,
    this.listerMessage,
    this.listerMessageUint8List,
  });

  SocketServerAction copyWith({
    Map? info,
    void Function(SocketServerAction)? onClose,
    void Function(SocketServerAction)? onConnection,
    void Function(SocketServerAction, dynamic message)? listerMessage,
    void Function(SocketServerAction, Uint8List message)? listerMessageUint8List,
  }) {
    return SocketServerAction(
      id: id,
      socket: socket,
      info: info ?? this.info,
      onClose: onClose ?? this.onClose,
      onConnection: onConnection ?? this.onConnection,
      listerMessage: listerMessage ?? this.listerMessage,
      listerMessageUint8List: listerMessageUint8List ?? this.listerMessageUint8List,
    );
  }
}
