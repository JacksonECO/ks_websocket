import 'package:flutter_test/flutter_test.dart';
import 'package:ks_websocket/src/ks_log.dart';
import 'package:ks_websocket/src/socket/client/ks_socket.dart';
import 'package:ks_websocket/src/socket/server/ks_socket_server.dart';
import 'package:ks_websocket/src/websocket/client/ks_websocket.dart';

const String ipHost = '127.0.0.1';
const int ipPort = 3456;

void main() {
  setUp(() {
    KsLogConfig.defaultStatic();
  });
  test('KsLog', () {
    KsLogConfig.isProduction = false;
    ksLog('message', name: 'test');
    try {
      KsLogConfig.log = (message, {name}) => throw 'Fall';
      ksLog('message', name: 'test');
      expect(false, isTrue);
    } catch (e) {
      expect(e.toString(), equals('Fall'));
    }
  });
  test('Ensure Socket', () async {
    final server = await KsSocketServer.bind(ipHost, ipPort);
    print(server.url);

    server.listerConnection((clientAction) => clientAction.copyWith(
          listerMessage: (message, data) {
            print('listerMessage: $data');
          },
          onClose: (message) {
            print('onClose');
          },
          onConnection: (p0) => print('onConnection'),
        ));

    final client = await KsSocket.connect(ipHost, ipPort);

    await Future.delayed(const Duration(milliseconds: 10), () => client.send('Hello'));
    await Future.delayed(const Duration(milliseconds: 10), () => client.send('Hello1'));

    await Future.delayed(const Duration(milliseconds: 10), () async => await client.close());
  });

  test('Ensure WebSocket', () async {
    //? The server used transfers the data in the form of a String

    final client = await KsWebSocket.connect(
      'wss://demo.piesocket.com/v3/Ks_socket?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self',
    );

    client.listen((message) {
      print(message);
    }, false);

    await Future.delayed(const Duration(milliseconds: 500), () => client.write('Message send number 1'));
    await Future.delayed(const Duration(milliseconds: 500), () => client.write('Message send number 2'));

    await Future.delayed(const Duration(seconds: 1), () => client.close());
  });
}
