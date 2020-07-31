import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'message.dart';
import 'main.dart';
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
      //https://chatapp45.herokuapp.com/
     socketOptions=new SocketOptions("https://chatapp45.herokuapp.com",enableLogging: true,transports: [Transports.WEB_SOCKET,Transports.POLLING]);
    socketConfig();
  }
Future<void>loadname() async{
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
_name=sharedPreferences.getString("Name");
}

void newusercreatea(){
  socket.emit("new-user", [{"name":_name}]);
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
    socket.on("user-connected",(data){
 
      _showSnackBar(data+" has joined",Colors.green);
    });
    socket.on("user-disconnected", (data) { 
      _showSnackBar(data+"has Disconnected",Colors.redAccent);
    });
}
_showSnackBar(data,color){
  _scaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: color,content: Text("$data"),duration: Duration(seconds: 1)));
}

void logout() async{
  String name=_name+"User Disconnected";
  socket.emit("disconnected", [{"name":name}]);
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences.clear().then((value) => {
  
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Initial()))
  });

}
Future<void> socketConfig() async {
    loadname();
    manager = SocketIOManager();
 socket = await manager.createInstance(socketOptions);    
		socket.connect();
   
	onrecieve();
  newusercreatea();
	}
  List<dynamic> messages=new List<dynamic>();
  List<bool> isself=new List<bool>();
  List<dynamic> name=new List<dynamic>();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return
 Scaffold(
   appBar: AppBar(
     title: Text("Chat"),
   ),
   drawer: Drawer(
     child: Container(
       width: size.width/2.5,
       color: Colors.white,
       child: Column(
         children: [
           Container(
               height: size.height*0.2,
               width: size.width/2.5,
                color: Colors.orange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Icon(Icons.chat_bubble,size: size.height/10,color: Colors.white,)),
                    Center(child: Text("ChatApp",style: TextStyle(fontSize: size.height/40,color: Colors.white),),)
                  ],
                ),
           ),

           InkWell(
                        child: Container(
                              margin: EdgeInsets.only(top: size.height/100),
               height: size.height*0.07,
               width: size.width/2.5,
                color: Colors.blueAccent,
               child: Center(child: Text("Create Room",style: TextStyle(color: Colors.white),)),),
           ),
           
             InkWell(
               onTap: (){
                 logout();
               },
                        child: Container(
                          margin: EdgeInsets.only(top: size.height/100),
               height: size.height*0.07,
               width: size.width/2.5,
                color: Colors.blueAccent,
               child: Center(child: Text("Log out",style: TextStyle(color: Colors.white),)),),
           ),
           InkWell(
                        child: Container(
                              margin: EdgeInsets.only(top: size.height/100),
               height: size.height*0.07,
               width: size.width/2.5,
                color: Colors.blueAccent,
               child: Center(child: Text("About Us",style: TextStyle(color: Colors.white),)),),
           )
         ],
       ),
     ),
   ),
   key: _scaffoldKey,
      body: 
        
         SingleChildScrollView(
                    child: Container(
                      
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Message(messages: messages,isself:isself ,name: name,),
                  Container(
                   
                    width: size.width,
                  color: Colors.red,
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
                           height: size.height*0.1,
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
