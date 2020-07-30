import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'message.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
@override
Widget build(BuildContext context) {
  return MaterialApp(
    
    home: MyAppWidget(),
  );
}
}
class MyAppWidget extends StatefulWidget{
  @override
 
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppWidget> {
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
  List<dynamic> texts=new List<dynamic>();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return
 Scaffold(
      body: SingleChildScrollView(
              child: Container(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Message(messages: texts,),
              Container(
               
                width: size.width,
                height: size.height*0.1,
                child: Row(
                  children: [

                    Container(
                      width: size.width*0.8,
                 
                        child: TextFormField(
                          controller: textEditingController,
                          style: TextStyle(fontSize: size.height/35),
                          decoration: InputDecoration(
                            border: InputBorder.none
                          ),
                        ),
                      
                    ),
                    Container(
                      
                       width: size.width*0.2,
                       height: size.height*0.2,
                      child: RaisedButton(
                        color: Colors.black,
                        highlightColor: Colors.blueAccent,
                        highlightElevation: 30,
                        child: Icon(Icons.send,color: Colors.orangeAccent,size: size.height/30,),
                        onPressed: 
                      (){
                        setState(() {
                          texts.add(textEditingController.text.toString());
                        });
                      }),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    
    );
  }
}
