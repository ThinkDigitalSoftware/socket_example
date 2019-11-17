import 'dart:io';

class ChatClient {
  Socket _socket;
  String _address;
  int _port;

  ChatClient(this._socket) {
    _address = _socket.address.address;
    _port = _socket.remotePort;
  }

  void write(String s) => _socket.write(s);

  void listen(void Function(List<int> data) param0, {void Function() onDone, void Function(error) onError}) =>_socket.listen;
}
