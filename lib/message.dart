import 'package:flutter/material.dart';

class Message extends StatefulWidget{
  final List<dynamic> messages;
  final List<bool> isself;
  const Message({Key key, this.messages, this.isself}) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  @override
  
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
    color: Colors.blueGrey,
      height: size.height*0.9,
      width: size.width,
      child:ListView.builder(
        itemCount: widget.messages.length,
        itemBuilder: (context,index){
        return Container(
         
          child: Align(
            alignment: widget.isself[index]?Alignment.centerRight:Alignment.centerLeft,
                      child: Container(
 margin: EdgeInsets.all(5),
            width: size.width/2,
            height: size.height/20,
            color:widget.isself[index]?Colors.blue:Colors.greenAccent,
            child: Text("${widget.messages[index]}",textAlign: widget.isself[index]?TextAlign.right:TextAlign.left,),
            ),
          ),
        );
      })
    );
  }
}