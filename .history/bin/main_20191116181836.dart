import 'dart:io';
import 'chat_client.dart';

main(List<String> arguments) async {
  final ServerSocket server =
      await ServerSocket.bind(InternetAddress.anyIPv4, 2000);
  await for (final Socket client in server) {
    handleConnection(client);
    print("Remote Addr: ${client.remoteAddress.address}");
  }
}

handleConnection(Socket client) {
  print(
      "Connection from ${client.remoteAddress.address}: ${client.remotePort}");
      final client = ChatClient(client);
  clients.add();
  client.write(
      "Welcome to the Dart server! There are ${clients.length - 1} other clients in this chat.");
 Chat.listen(
        (List<int> data) => messageHandler(String.fromCharCodes(data).trim()),
        onDone: finishedHandler,
        onError: errorHandler);

}

 void messageHandler(Socket _socket, String message) {
    if (message == '/disconnect') {
      _socket.writeln('Goodbye!');
      _socket.close();
    } else {
      distributeMessage(this, '${_address}:${_port} Message: $message');
    }
  }

  void errorHandler(error) {
    print('${_address}:${_port} Error: $error');
    removeClient(this);
    _socket.close();
  }

  void finishedHandler() {
    distributeMessage(this, "${this._address} has disconnected.");
    print('${_address} with hashcode: ${hashCode} disconnected.');

    removeClient(this);
    _socket.close();
  }

  void write(String message) {
    _socket.write(message);
  }