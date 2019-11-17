import 'dart:io';


class ChatClient {
  Socket socket;
  String address;
  int port;

  ChatClient(this.socket) {
    address = socket.address.address;
    port = socket.remotePort;
  }


}
