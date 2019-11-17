import 'dart:io';

Socket socket;
main()async {
  socket = await Socket.connect('127.0.0.1', 2000);
}