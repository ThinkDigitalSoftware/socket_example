import 'dart:io';

import 'package:socket_example/socket_example.dart' as socket_example;

main(List<String> arguments)async  {
  final ServerSocket server = await ServerSocket.bind('127.0.0.1', 2000);
  await for (final Socket request in server)){
    print()
  }
}
