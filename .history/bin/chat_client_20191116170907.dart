import 'dart:io';

class ChatClient {
  Socket _socket;
  String _address;
  int _port;

  ChatClient(Socket socket){
    this._socket = socket
  }
}