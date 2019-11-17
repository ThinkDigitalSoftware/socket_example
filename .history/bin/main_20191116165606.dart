import 'dart:io';

import 'package:socket_example/socket_example.dart' as socket_example;

main(List<String> arguments) {
  ServerSocket.bind('127.0.0.1', 2000);
}
