import 'dart:io';


class ChatClient {
  Socket socket;
  String address;
  int _port;

  ChatClient(this.socket) {
    address = socket.address.address;
    _port = socket.remotePort;
  }


}
