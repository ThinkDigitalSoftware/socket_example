import 'dart:io';

Socket socket;
main()async {
  await Socket.connect('127.0.0.1', 2000);
}