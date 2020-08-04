import 'package:flutter/cupertino.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Socket{
final String username;
final String socketUrl;
 SocketIOManager manager;
 final  SocketOptions socketOptions;
 SocketIO socket;
  Socket({@required this.socketUrl,@required this.socketOptions,@required this.username});


Future<void> socketConfig() async {
   // loadname();
    manager = SocketIOManager();
 socket = await manager.createInstance(socketOptions);    
		socket.connect();
   
	//onrecieve();
 // newusercreatea();
	}
  void newusercreatea(){
  socket.emit("new-user", [{"name":username}]);
}
void sendimage(file){
  socket.emit("ImageFile", [{"name":username,"Image":file}]);
}
void sendmessage(msg){
  socket.emit("msg", [{"name":username,"msg":msg}]);
}
  

  Future<void> logout() async{
  String name=username+"User Disconnected";
  socket.emit("disconnected", [{"name":name}]);
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
    
    
  

}
  
