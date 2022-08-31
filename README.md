
This library was built to facilitate the use of `WebSocket` and `Socket`, both client and server. For that, the same interface was created and the necessary implementations were carried out using `dart:io` and `dart:html`.

In this way it is possible to program for web and android (for example), with the same code, without worrying about importing `dart:html` for `io` devices.


# Example

```dart
final server = await KsSocketServer.bind(ipHost, ipPort);

server.listerConnection((clientAction) => clientAction.copyWith(
    listerMessage: (message, data) {
        print('listerMessage: $data');
    },
    onClose: (message) {
        print('onClose');
    },
    onConnection: (_) => print('New Connection'),
));


final client = await KsSocket.connect(ipHost, ipPort);

client.send('Hello'));
client.send({
    'id': 1005,
    'user': 'name',
}));
await Future.delayed(const Duration(seconds: 1));
await client.close();

```


# Upcoming Versions:

- Implement the WebSocket server;
- Create unit tests;
- Develop a test application;


# Additional information

Feel Free to request any missing features or report issues [here](https://github.com/JacksonECO/ks_websocket/issues).




<!-- pt-br
Esta biblioteca foi construída para facilitar a utilização de `WebSocket` e `Socket`, tanto o cliente quanto o servidor. Para isso foi criado uma mesma interface e realizados as devidas implementações utilizando o `dart:io` e `dart:html`. 

Desde modo é possível programar para web e android ( por exemplo), com o mesmo código, sem se preocupar com o import do `dart:html` para dispositivos `io`.


# Próximas Versões:

- Implementar o server do WebSocket;
- Criar testes unitários;
- Desenvolver um aplicativo de teste;
-->