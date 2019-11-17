import 'dart:io';

class ChatClient {
  Socket _socket;
  String _address;
  int _port;

  ChatClient(this._socket){
    _address = _socket.address.address;
    _port = _socket.remotePort;

    _socket.listen(messageHandler, onDone: finishedHandler, onError: errorHandler);
  }

  void messageHandler(List data){
    String message =  String.fromCharCodes(data).trim();
    distributeMessage(this, '${_address}:${_port} Message: $message');
  }

  void errorHandler(error){
    print('${_address}:${_port} Error: $error');
    removeClient(this);
    _socket.close();
  }

  void finishedHandler() {
    print('${_address}:${_port} Disconnected');
    removeClient(this);
    _socket.close();
  }

  void write(String message){
    _socket.write(message);
  }
}
List<ChatClient> clients = [];

void removeClient(Socket client)
distributeMessage(ChatClient client, String message){
  for( ChatClient chatClient in clients){
    if(chatClient != client){
      chatClient.write(message);
    }
  }
}