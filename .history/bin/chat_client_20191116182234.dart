import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

class ChatClient {
  Socket _socket;
  String _address;
  int _port;

  ChatClient(this._socket) {
    _address = _socket.address.address;
    _port = _socket.remotePort;
  }

  void write(String s) => _socket.write(s);

  StreamSubscription<Uint8List>  get listen=> _socket.listen;
}
