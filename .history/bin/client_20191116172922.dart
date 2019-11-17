import 'dart:io';

Socket socket;
main() async {
  try {
    socket = await Socket.connect('127.0.0.1', 2000);
    socket.listen(dataHandler,
        onError: errorHandler, onDone: doneHandler, cancelOnError: false);
  } catch (e) {
    print("Unable to connect: $e");
    exit(1);
  }
  stdin.listen((data){
    socket.write(obj)
  });
}
