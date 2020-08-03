import 'package:flutter/material.dart';
import 'dart:convert';
class Messages extends StatefulWidget{
  final List<dynamic> messages;
  final List<bool> isself;
  final List<dynamic> name;
  final List<bool> isImage;

  const Messages({Key key, this.messages, this.isself, this.name, this.isImage}) : super(key: key);
  
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
           Container(
      color: Color(0xFFf0fcdb),
        height: size.height*0.82,
        width: size.width,
        child:ListView.builder(
         
          itemCount: widget.messages.length,
          itemBuilder: (context,index){
          return Row(
                      children:[ Expanded(
             
              child: Align(
                alignment: widget.isself[index]?Alignment.centerRight:Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                  color:widget.isself[index]?Colors.blue:Colors.white,
                              borderRadius: BorderRadius.circular(size.height/70)),
                          margin: EdgeInsets.all(size.height/180),
                          width: size.width/1.5,
                            
               
             
                child:widget.isImage[index]?
                Container(
                
                decoration: BoxDecoration(
                  image: DecorationImage(image:
                  widget.isself[index]?FileImage(widget.messages[index]):
                  MemoryImage(
                    base64.decode("${widget.messages[index]}")
                    ),fit: BoxFit.contain)
                ),
                ):
               
                Container(
                  margin: EdgeInsets.all(size.height/70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                     
                        child: Text("${widget.name[index]}",textAlign: TextAlign.left,style: TextStyle(fontSize: size.height/70,color: widget.isself[index]?Colors.white:Colors.grey))),
                      Container(
                          
                        child: Text("${widget.messages[index]}",textAlign: TextAlign.left,style: TextStyle(fontSize: size.height/45,color: widget.isself[index]?Colors.white:Colors.black))),
                    ],
                  )),
                  
                ),
                ),
              
            ),
                      ]);
        })
      
    );
  }
}