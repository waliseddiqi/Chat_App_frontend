import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications{

final notificationTask="SimpleNotification";

void _showNotification(v,flp)async{
var android=AndroidNotificationDetails("channelId", "channelName", "channelDescription"
,priority: Priority.High,importance: Importance.Max
);
var ios=IOSNotificationDetails();
var platform=NotificationDetails(android, ios);
await flp.show(0,"New Message",'$v',platform,payload:"VTS \n $v");

}

Future<void> initWorkManager(callbackDispatcher) async{
WidgetsFlutterBinding.ensureInitialized();

await Workmanager.initialize(callbackDispatcher,isInDebugMode: true);
Workmanager.registerPeriodicTask("Notify", notificationTask
,existingWorkPolicy: ExistingWorkPolicy.replace,
initialDelay: Duration(seconds: 5),
frequency: Duration(minutes: 1),
constraints:Constraints(
  networkType: NetworkType.connected,
));

}
void callbackDispatcher(){
Workmanager.executeTask((task, inputData)async{
FlutterLocalNotificationsPlugin flp=FlutterLocalNotificationsPlugin();
var android=AndroidInitializationSettings("@mipmap/ic_launcher");
var ios=IOSInitializationSettings();
var initSettings=InitializationSettings(android, ios);
flp.initialize(initSettings);
//show notification here;
_showNotification("msg", flp);
return Future.value(true);
});
}

}