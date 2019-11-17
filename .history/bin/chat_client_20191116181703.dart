import 'dart:io';

class ChatClient {
  Socket _socket;
  String _address;
  int _port;

  ChatClient(this._socket) {
    _address = _socket.address.address;
    _port = _socket.remotePort;

    _socket.listen(
        (List<int> data) => messageHandler(String.fromCharCodes(data).trim()),
        onDone: finishedHandler,
        onError: errorHandler);
  }

 
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
