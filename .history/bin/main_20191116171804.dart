import 'dart:io';

main(List<String> arguments)async  {
  final ServerSocket server = await ServerSocket.bind(I, 2000);
  await for (final Socket client in server){
    print("Remote Addr: ${client.remoteAddress.address}");
    client.write('Hey there, from remote server!\n');
    await client.close();
  }
}
