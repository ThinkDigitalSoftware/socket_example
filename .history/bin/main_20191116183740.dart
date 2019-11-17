import 'dart:io';
import 'chat_client.dart';

main(List<String> arguments) async {
  print('Starting server');
  final ServerSocket server =
      await ServerSocket.bind(InternetAddress.anyIPv4, 2000);
  await for (final Socket client in server) {
    handleConnection(client);
    print("Remote Addr: ${client.remoteAddress.address}");
  }
}

handleConnection(Socket client) {
  print(
      "Connection from ${client.remoteAddress.address}: ${client.remotePort}\n Hashcode: ${client.hashCode}");
  final chatClient = ChatClient(client);
  clients.add(chatClient);
  client.write(
      "Welcome to the Dart server! There are ${clients.length - 1} other clients in this chat.");
  client.listen(
      (List<int> data) =>
          messageHandler(chatClient, String.fromCharCodes(data).trim()),
      onDone: () => finishedHandler(chatClient),
      onError: (error) => errorHandler(chatClient, error));
}

void messageHandler(ChatClient chatClient, String message) {
  final _socket = chatClient.socket;
  if (message == '/disconnect') {
    _socket.writeln('Goodbye!');
    _socket.close();
  } else {
    distributeMessage(chatClient,
        '${chatClient.address}:${chatClient.port} Message: $message');
    stdout.writeln(message);
  }
}

void errorHandler(ChatClient chatClient, error) {
  print('${chatClient.address}:$chatClient.port} Error: $error');
  removeClient(chatClient);
  chatClient.socket.close();
}

void finishedHandler(ChatClient chatClient) {
  distributeMessage(chatClient, "${chatClient.address} has disconnected.");
  print(
      '${chatClient.address} with hashcode: ${chatClient.hashCode} disconnected.');

  removeClient(chatClient);
  chatClient.socket.close();
}

void write(ChatClient chatClient, String message) {
  chatClient.socket.write(message);
}

List<ChatClient> clients = [];

void removeClient(ChatClient client) {
  clients.removeWhere((_client) => _client.hashCode == client.hashCode);
}

distributeMessage(ChatClient chatClient, String message) {
  for (ChatClient client in clients) {
    if (client != chatClient) {
      client.socket.write(message);
    }
  }
}
