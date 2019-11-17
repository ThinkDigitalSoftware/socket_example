import 'dart:io';

import 'package:socket_example/socket_example.dart' as socket_example;

main(List<String> arguments)async  {
  ServerSocket.bind('127.0.0.1', 2000);
}
