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
  final chatClient = ChatClient(client);
  clients.add(chatClient);
  client.write(
      "Welcome to the Dart server! There are ${clients.length - 1} other clients in this chat.");
  client.listen(
      (List<int> data) => messageHandler(chatClient, String.fromCharCodes(data).trim()),
      onDone: finishedHandler,
      onError: errorHandler);
}

void messageHandler(ChatClient chatClient, String message) {
  final _socket = chatClient.socket;
  if (message == '/disconnect') {
    _socket.writeln('Goodbye!');
    _socket.close();
  } else {
    distributeMessage(chatClient, '${chatClient.address}:${chatClient.port} Message: $message');
  }
}

void errorHandler(ChatClient chatClient, error) {
  print('${chatClient.address}:$chatClient.port} Error: $error');
  removeClient(chatClient);
  chatClient.socket.close();
}

void finishedHandler(ChatClient chatClient) {
  distributeMessage(this, "${this._address} has disconnected.");
  print('${_address} with hashcode: ${hashCode} disconnected.');

  removeClient(this);
  _socket.close();
}

void write(String message) {
  _socket.write(message);
}

List<ChatClient> clients = [];

void removeClient(ChatClient client) {
  clients.removeWhere((_client) => _client.hashCode == client.hashCode);
}

distributeMessage(ChatClient client, String message) {
  for (ChatClient chatClient in clients) {
    if (chatClient != client) {
      chatClient.write(message);
    }
  }
}
