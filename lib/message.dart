import 'package:flutter/material.dart';

class Message extends StatefulWidget{
  final List<dynamic> messages;
  final List<bool> isself;
  final List<dynamic> name;
  const Message({Key key, this.messages, this.isself, this.name}) : super(key: key);
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
                        decoration: BoxDecoration(
                              color:widget.isself[index]?Colors.blue:Colors.greenAccent,
                          borderRadius: BorderRadius.circular(size.height/70)),
                      margin: EdgeInsets.all(5),
                      width: size.width/1.8,
                      height: size.height/12,
        
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: size.width/60),
                  child: Text("${widget.name[index]}",textAlign: widget.isself[index]?TextAlign.left:TextAlign.right,style: TextStyle(fontSize: size.height/80,color: Colors.white))),
                Text("${widget.messages[index]}",textAlign: widget.isself[index]?TextAlign.left:TextAlign.right,style: TextStyle(fontSize: size.height/50)),
              ],
            ),
            ),
          ),
        );
      })
    );
  }
}