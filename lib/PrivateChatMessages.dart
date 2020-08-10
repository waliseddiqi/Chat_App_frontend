
import 'package:ChatApp/Clients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'message.dart';
import 'env.dart';

class PrivateChatMessages extends StatefulWidget{
  @override
  _PrivateChatMessagesState createState() => _PrivateChatMessagesState();
}

 

class _PrivateChatMessagesState extends State<PrivateChatMessages> {
  @override
  SocketIOManager manager;
   SocketOptions socketOptions;
  SocketIO socket;
  String _name="";
  void initState() { 
    super.initState();
    socketOptions=new SocketOptions(Env.devUrl,enableLogging: true,transports: [Transports.WEB_SOCKET,Transports.POLLING]);
    socketConfig();
    
  }
    Future<void> socketConfig() async {
    loadname();
    manager = SocketIOManager();
 socket = await manager.createInstance(socketOptions);    
		socket.connect();
   
	onrecieve();
  //newusercreatea();
	}
  onrecieve(){
    socket.on("$_name", (data) { 
      print(data[1]);
      print(data[0]);
    });
  }
  void sendmessage(msg){
  socket.emit("msg", [{"name":_name,"msg":msg}]);
}
  Future<void>loadname() async{
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
_name=sharedPreferences.getString("Name");
}
TextEditingController textEditingController=new TextEditingController();
 @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return

   Scaffold(
     appBar: AppBar(),
       backgroundColor:  Color(0xFFf0fcdb),
     
       //key: _scaffoldKey,
     body: 
       
        Center(
                   child: Container(
                    
             
             child: SingleChildScrollView(
        
                             child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Messages(isprivatemessages: true,),
                   
                  
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
                               
                                     //sendmessage(textEditingController.text.toString());
                                       var clientMessages=Provider.of<Clients>(context,listen: false);
                                      clientMessages.setprivatemessages(true, textEditingController.text.toString(), "You");
                                        textEditingController.clear();
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