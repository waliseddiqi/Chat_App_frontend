import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SocketIOManager manager;
   SocketOptions socketOptions;
  SocketIO socket;
TextEditingController textEditingController=new TextEditingController();
String text;
  @override
  void initState() {
    super.initState();
     socketOptions=new SocketOptions("http://192.168.137.1:3000",enableLogging: true,transports: [Transports.WEB_SOCKET,Transports.POLLING]);
    socketConfig();
  }

void sendmessage(msg){
  socket.emit("msg", [msg]);
}
void onrecieve(){
	socket.on("chat-message", (data){   //sample event
		  print("news");
		 print(data);
     setState(() {
       text=data;
     });
		});
}
Future<void> socketConfig() async {
    manager = SocketIOManager();
 socket = await manager.createInstance(socketOptions);    
		socket.connect();
	onrecieve();
	}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home: Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Socket io here"),
            TextField(controller:textEditingController),
            RaisedButton(
              onPressed: () {
                sendmessage(textEditingController.text.toString());
              },
              child: Container()
            ),
            Text("$text")
          ],
        ),
      ),
    ),
    );
  }
}
