import 'package:ChatApp/Clients.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PrivateChatMessages.dart';
class PrivateChat extends StatefulWidget{
  @override
  _PrivateChatState createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Consumer<Clients>(
          builder: (context,data,child){
return Container(
width: size.width,
height: size.height,
   
               child:ListView.builder(
                 itemCount: data.lenght,
                 itemBuilder: (context,index){
return        InkWell(
  onTap: (){
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PrivateChatMessages()));
  },
  child:   Container(
  
    margin: EdgeInsets.only(bottom: size.height/30),
  
                    height: size.height/10,
  
                    color: Colors.black,
  
                    child: Center(child: Text("${data.clients[index]}",style: TextStyle(fontSize: size.height/50,color: Colors.white),)),
  
                ),
);
                 },
                      
               )
            
          );
          },
                
        ),
      ),
    ) ;
  }
}