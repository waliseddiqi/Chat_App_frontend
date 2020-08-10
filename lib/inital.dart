
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'message.dart';
import 'main.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'env.dart';
import 'package:provider/provider.dart';
import 'Clients.dart';
import 'PrivateChat.dart';
import 'ClientMessagesPrivate.dart';
class MyApp extends StatelessWidget {
  @override
@override
Widget build(BuildContext context) {
  return ChangeNotifierProvider(
    create: (context) => Clients(),
      child: MaterialApp(
      
      home: MyAppWidget(),
    ),
  );
}
}
class MyAppWidget extends StatefulWidget{
  @override
 
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppWidget> {

 File _image;
  final picker = ImagePicker();
    SocketIOManager manager;
   SocketOptions socketOptions;
  SocketIO socket;
TextEditingController textEditingController=new TextEditingController();
String text;
String _name="";
 GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
String notificationTask="no simple anymore";

   @override
  void initState() {
    super.initState();
     socketOptions=new SocketOptions(Env.productionUrl,enableLogging: true,transports: [Transports.WEB_SOCKET,Transports.POLLING]);
    socketConfig();
    
  }
  Future<void> socketConfig() async {
    loadname();
    manager = SocketIOManager();
 socket = await manager.createInstance(socketOptions);    
		socket.connect();
   
	onrecieve();
  newusercreatea();
	}
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
     _image = File(pickedFile.path);
     String dedata;
     var clientMessages=Provider.of<Clients>(context,listen: false);
     clientMessages.setmessage(_image, "You", true, true);
_image.readAsBytes().then((value) => {
  dedata=base64Encode(value),
   
  sendimage(dedata)
});
  
  }
Future<void>loadname() async{
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
_name=sharedPreferences.getString("Name");
}

void newusercreatea(){
  socket.emit("new-user", [{"name":_name}]);
}
void sendimage(file){
  socket.emit("ImageFile", [{"name":_name,"Image":file}]);
}
void sendmessage(msg){
  socket.emit("msg", [{"name":_name,"msg":msg}]);
}
void onrecieve(){
	socket.on("chat-message", (data){  

  var clientMessages=Provider.of<Clients>(context,listen: false);
  clientMessages.setmessage(data[1], data[0], false, false);
		});
    socket.on("user-connected",(data){
 
      _showSnackBar(data+" has joined",Colors.green);
      var clients=Provider.of<Clients>(context,listen: false);
      clients.clients=data;
    });
    socket.on("user-disconnected", (data) { 
      _showSnackBar(data+"has Disconnected",Colors.redAccent);
      print(data);
      var clients=Provider.of<Clients>(context,listen: false);
      clients.remove(data);
    });

    socket.on("get-Image", (data) { 
      try {
     var clientMessages=Provider.of<Clients>(context,listen: false);
     clientMessages.setmessage(data[1],data[0], false, true);
      
      } catch (e) {
        //print(e);
      }
   
     
    });
}
_showSnackBar(data,color){
  _scaffoldKey.currentState.showSnackBar(SnackBar(backgroundColor: color,content: Text("$data"),duration: Duration(seconds: 1)));
}


void logout() async{
  String name=_name;
  socket.emit("disconnected", [{"name":name}]);
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences.clear().then((value) => {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Initial()))
  });

}

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return
 Scaffold(
   backgroundColor:  Color(0xFFf0fcdb),
   appBar: AppBar(
     title: Text("Chat"),
   ),
   drawer: Drawer(
     child: Container(
      
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
             onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PrivateChat()));
             },
                        child: Container(
                              margin: EdgeInsets.only(top: size.height/100),
               height: size.height*0.08,
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
        
         Center(
                    child: Container(
                     
              
              child: SingleChildScrollView(
         
                              child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Messages(isprivatemessages: false,),
                    
                   
                                         Container(
                                           
                        width: size.width,
                      decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(size.height/25),
                              color: Colors.white
                              ),
                        height: size.height*0.08,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [

                            Container(
                             
                              width: size.width*0.70,
                              
                                margin: EdgeInsets.only(left: size.width/50),
                                child: TextFormField(
                                
                                  controller: textEditingController,
                                  style: TextStyle(fontSize: size.height/35),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Say Something"
                                  ),
                                ),
                              
                            ),
                            Container(
                                width: size.width*0.25,
                         
                               height: size.height*0.1,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                  
                                 
                                     width: size.width*0.125,
                               height: size.height*0.1,
                                    child: InkWell(
                                 
                                     
                               
                                      child: Icon(Icons.send,color: Colors.orangeAccent,size: size.height/35,),
                                      onTap: 
                                    (){
                                
                                      sendmessage(textEditingController.text.toString());
                                        var clientMessages=Provider.of<Clients>(context,listen: false);
                                       
                                        clientMessages.setmessage(textEditingController.text.toString(), "You", true, false);
                                         textEditingController.clear();
                                         
                                    }),
                                  ),
                                     Container(
                                     
                                
                                     width: size.width*0.125,
                               height: size.height*0.1,
                                    child: InkWell(
                                 
                                     
                               
                                      child: Icon(Icons.photo_library,color: Colors.orangeAccent,size: size.height/35,),
                                      onTap: 
                                    (){
                                     getImage();
                                    }),
                                  ),
                                  
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  
                  ],
                ),
              )
            ),
         ),
    
    
   );

    
  }
}
