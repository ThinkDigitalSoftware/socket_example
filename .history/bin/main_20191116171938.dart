import 'dart:io';

main(List<String> arguments)async  {
  final ServerSocket server = await ServerSocket.bind(InternetAddress.anyIPv4, 2000);
  await for (final Socket client in server){
    client.listen(onData)
    print("Remote Addr: ${client.remoteAddress.address}");
    client.write('Hey there, from remote server!\n');
    await client.close();
  }
}
