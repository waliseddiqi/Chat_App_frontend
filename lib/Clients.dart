


import 'package:flutter/material.dart';

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

}