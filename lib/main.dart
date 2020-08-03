import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inital.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
/*SocketIOManager manager;
   SocketOptions socketOptions;
  SocketIO socket;*/
/*void _showNotification(v,flp)async{
var android=AndroidNotificationDetails("channelId", "channelName", "channelDescription"
,priority: Priority.High,importance: Importance.Max
);
var ios=IOSNotificationDetails();
var platform=NotificationDetails(android, ios);
await flp.show(0,"New Message",'$v',platform,payload:"VTS \n $v");

}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData)async{
FlutterLocalNotificationsPlugin flp=FlutterLocalNotificationsPlugin();
var android=AndroidInitializationSettings("@mipmap/ic_launcher");
var ios=IOSInitializationSettings();
var initSettings=InitializationSettings(android, ios);
flp.initialize(initSettings);

//show notification here;

socketConfig().then((value) => {
socket.on("chat-message", (data) {
   print("Heyy");
      //sample event
    _showNotification("lkkljlkjl", flp);
 })
});


    return Future.value(true);
  });
}

Future<void> socketConfig() async {
    socketOptions=new SocketOptions("http://192.168.137.1:3000",enableLogging: true,transports: [Transports.WEB_SOCKET,Transports.POLLING]);
    manager = SocketIOManager();
 socket = await manager.createInstance(socketOptions);    
		socket.connect();

	}
  */
void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
    isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
 Workmanager.registerPeriodicTask("Notify", "Simple task here complicated"
,existingWorkPolicy: ExistingWorkPolicy.replace,
initialDelay: Duration(seconds: 5),

constraints:Constraints(
  networkType: NetworkType.connected,
));*/
//Android only (see below)
  runApp(Initial());
}
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