


import 'package:ChatApp/PrivateChatMessages.dart';
import 'package:flutter/material.dart';
import 'ClientMessages.dart';
import 'ClientMessagesPrivate.dart';
class Clients extends ChangeNotifier{

List<String> _clients=[];


set clients(value){
_clients.add(value);
notifyListeners();

}
get clients{
  return _clients;
}
get lenght{
  return _clients.length;
}

void remove(value){
_clients.remove(value);
_clients.join(", ");
notifyListeners();
}

List<ClientMessages> clientMessages=[];
List<ClientMessagesPrivate> privatemessages=[];
void setmessage(message,name,isself,isimage){
  ClientMessages client=new ClientMessages();
  client.isImage=isimage;
  client.message=message;
  client.isSelf=isself;
  client.name=name;
clientMessages.add(client);
notifyListeners();
}
getmessage(){
 return clientMessages;
}
void setprivatemessages(bool isSelf, String message,String name){
  ClientMessagesPrivate clientMessagesPrivate=new ClientMessagesPrivate();
  clientMessagesPrivate.isSelf=isSelf;
  clientMessagesPrivate.message=message;
  clientMessagesPrivate.name=name;
  privatemessages.add(clientMessagesPrivate);
  notifyListeners();


}
getprivatemessages(){
  return privatemessages;
}
}