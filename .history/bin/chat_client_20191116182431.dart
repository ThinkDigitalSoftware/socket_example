import 'dart:io';


class ChatClient {
  Socket socket;
  String _address;
  int _port;

  ChatClient(this.socket) {
    _address = socket.address.address;
    _port = socket.remotePort;
  }


}
