import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'message.dart';

import 'package:shared_preferences/shared_preferences.dart';
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
String _name="";
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
      
     socketOptions=new SocketOptions("https://chatapp45.herokuapp.com/",enableLogging: true,transports: [Transports.WEB_SOCKET,Transports.POLLING]);
    socketConfig();
  }
loadname() async{
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
_name=sharedPreferences.getString("Name");
}

void newusercreatea(){
  socket.emit("new-user", [_name]);
}
void sendmessage(msg){
  socket.emit("msg", [{"name":_name,"msg":msg}]);
}
void onrecieve(){
	socket.on("chat-message", (data){   //sample event
		
    
     // print(data);
     setState(() {
       messages.add(data[1]);
       name.add(data[0]);
     isself.add(false);
     });
		});
    socket.on("new-user",(data){
      print(data);
      _showSnackBar(data);
    });
}
_showSnackBar(data){
  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("$data has Joined Chat"),duration: Duration(milliseconds: 600)));
}
Future<void> socketConfig() async {
    loadname();
    manager = SocketIOManager();
 socket = await manager.createInstance(socketOptions);    
		socket.connect();
    newusercreatea();
	onrecieve();
	}
  List<dynamic> messages=new List<dynamic>();
  List<bool> isself=new List<bool>();
  List<dynamic> name=new List<dynamic>();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return
 Scaffold(
   key: _scaffoldKey,
      body: SingleChildScrollView(
              child: Container(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Message(messages: messages,isself:isself ,name: name,),
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
                        
                          sendmessage(textEditingController.text.toString());
                          messages.add(textEditingController.text.toString());
                          name.add("You");
                          isself.add(true);
                          textEditingController.clear();
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
