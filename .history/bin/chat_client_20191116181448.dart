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

  void messageHandler(String message) {
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
        print('${this.} with hashcode: ${client.hashCode} disconnected.');

    removeClient(this);
    _socket.close();
  }

  void write(String message) {
    _socket.write(message);
  }
}

List<ChatClient> clients = [];

void removeClient(ChatClient client){
  clients.removeWhere((_client)=> _client.hashCode == client.hashCode);
}

distributeMessage(ChatClient client, String message) {
  for (ChatClient chatClient in clients) {
    if (chatClient != client) {
      chatClient.write(message);
    }
  }
}
