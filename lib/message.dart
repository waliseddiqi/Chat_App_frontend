import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'Clients.dart';
import 'ImageView.dart';
class Messages extends StatefulWidget{
final isprivatemessages;
  const Messages({Key key, this.isprivatemessages}) : super(key: key);
  
  @override
  _MessageState createState() => _MessageState();
  
}

class _MessageState extends State<Messages> {

@override
void initState() { 
  super.initState();

 
}

@override
  void dispose() {
   
    super.dispose();
  }
  @override

  
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return 
           Consumer<Clients>(
             builder: (context,data,child){
               return  Container(
      color: Color(0xFFf0fcdb),
        height: size.height*0.82,
        width: size.width,
        child:
        
           !widget.isprivatemessages?Container(
             height: size.height*0.82,
        width: size.width,
             child: ListView.builder(
         
          itemCount: data.clientMessages.length,
          itemBuilder: (context,index){
          return Row(
                          children:[ Expanded(
                 
                  child: Align(
                    alignment: data.clientMessages[index].isSelf?Alignment.centerRight:Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                      color:data.clientMessages[index].isSelf?Colors.blue:Colors.white,
                                  borderRadius: BorderRadius.circular(size.height/70)),
                              margin: EdgeInsets.all(size.height/180),
                              width: size.width/1.5,
                                
                   
                 
                    child:data.clientMessages[index].isImage?
                    Container(
                        margin: EdgeInsets.all(size.height/110),
                      width: size.width/3.5,
                          height: size.height/3.5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                               child: Text("${data.clientMessages[index].name}",textAlign: TextAlign.left,style: TextStyle(fontSize: size.height/70,color: data.clientMessages[index].isSelf?Colors.white:Colors.grey))),
                              
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ImageView(image:data.clientMessages[index].message,isFile:data.clientMessages[index].isSelf,tag: "$index",)));
                            },
                                                    child: Hero(
                              tag: "$index",
                                                      child: Container(
                              width: size.width/4,
                              height: size.height/4,
                              decoration: BoxDecoration(
                                image: DecorationImage(image:
                              data.clientMessages[index].isSelf?FileImage(data.clientMessages[index].message):
                                MemoryImage(
                                  base64.decode("${data.clientMessages[index].message}")
                                  ),fit: BoxFit.cover)
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ):
                   
                    Container(
                      margin: EdgeInsets.all(size.height/70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                         
                            child: Text("${data.clientMessages[index].name}",textAlign: TextAlign.left,style: TextStyle(fontSize: size.height/70,color: data.clientMessages[index].isSelf?Colors.white:Colors.grey))),
                          Container(
                              
                            child: Text("${data.clientMessages[index].message}",textAlign: TextAlign.left,style: TextStyle(fontSize: size.height/45,color: data.clientMessages[index].isSelf?Colors.white:Colors.black))),
                        ],
                      )),
                      
                    ),
                    ),
                  
                ),
                          ]);
        }),
           ):
        Container(
          
          child: ListView.builder(
             
            itemCount: data.privatemessages.length,
            itemBuilder: (context,index){
            return Row(
                          children:[ Expanded(
                 
                  child: Align(
                    alignment: data.privatemessages[index].isSelf?Alignment.centerRight:Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                      color:data.privatemessages[index].isSelf?Colors.blue:Colors.white,
                                  borderRadius: BorderRadius.circular(size.height/70)),
                              margin: EdgeInsets.all(size.height/180),
                              width: size.width/1.5,
                              child:   
                    Container(
                      margin: EdgeInsets.all(size.height/70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                         
                            child: Text("${data.privatemessages[index].name}",textAlign: TextAlign.left,style: TextStyle(fontSize: size.height/70,color: data.privatemessages[index].isSelf?Colors.white:Colors.grey))),
                          Container(
                              
                            child: Text("${data.privatemessages[index].message}",textAlign: TextAlign.left,style: TextStyle(fontSize: size.height/45,color: data.privatemessages[index].isSelf?Colors.white:Colors.black))),
                        ],
                      )),
                              )
                              
                              ))]);
          }
          
          ),
        )
      
    );
             }
           );
  }
}