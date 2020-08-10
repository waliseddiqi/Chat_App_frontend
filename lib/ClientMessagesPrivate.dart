
//import 'package:http/http.dart' as http;
/*Future<http.Response> sendreq(_name)async{
List<int> number=List<int>.generate(32,(i)=>(Random.secure().nextInt(100)));
  String crypted=base64Url.encode(number);
  var data={"UserID":_name+"$crypted"};
return await http.post(Env.devUrl+"/private/room", headers: {"Content-Type": "application/json"},body:  json.encode(data));
}*/

class ClientMessagesPrivate{

bool isSelf;
String message;
String name;




}