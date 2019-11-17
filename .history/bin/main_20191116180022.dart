import 'dart:io';
import 'chat_client.dart';

main(List<String> arguments) async {
  final ServerSocket server =
      await ServerSocket.bind(InternetAddress.anyIPv4, 2000);
  await for (final Socket client in server) {
    handleConnection(client);
    print("Remote Addr: ${client.remoteAddress.address}");
    await client.drain();
    print('${')
  }
}

handleConnection(Socket client) {
  print(
      "Connection from ${client.remoteAddress.address}: ${client.remotePort}");
  clients.add(ChatClient(client));
  client.write(
      "Welcome to the Dart server! There are ${clients.length - 1} other clients in this chat.");
}
