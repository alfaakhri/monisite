import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseService  {
 
  Future<String> getToken() async{
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String token = await _firebaseMessaging.getToken();
    return token;
  }
}
