import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inital.dart';
void main() => runApp(Initial());
class Initial extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: InitialPage(),);
  }

}

class InitialPage extends StatefulWidget{
  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<InitialPage> {
TextEditingController textEditingController=new TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.addListener(texteditinglistener);
  }
  void texteditinglistener(){
      if(textEditingController.text.length>5){
        setState(() {
            buttonColor=Colors.black;
        });
      
      }
  }
Future<void> savename(name)async{
SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
sharedPreferences.setString("Name", name);

}
Color buttonColor=Colors.white;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Container(
                width: size.width,
                height: size.height/10,
                color: Colors.teal,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size.height/20,decoration: TextDecoration.none),
                  controller:textEditingController ,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Your NickName Please :)",
                    hintStyle:TextStyle(fontSize: size.height/25,)
                  ),
                  
                ),
              ),
              InkWell(
                onTap: (){
                  if(textEditingController.text.length>5){
                    savename(textEditingController.text.toString()).then((value) => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()))
                    });
                  
                  }
                },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 800),
                                curve: Curves.easeIn,
                                                              child: Container(
                                  margin: EdgeInsets.all(10),
                                    color: Colors.white,
                                    width: size.width/3,
                                     height: size.height/15,
                                  child: Center(
                                    child: Text("Enter",style: TextStyle(fontSize: size.height/30,color: buttonColor),),
                                  ),
                ),
                              ),
              )
            ],
          ),
        ),
      ) ,
    );
  }
}