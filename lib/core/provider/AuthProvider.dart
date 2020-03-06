import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_monisite/core/auth/authentication.dart';
import 'package:flutter_monisite/core/components/Failure.dart';
import 'package:flutter_monisite/core/routes/router.gr.dart';
import 'package:flutter_monisite/core/service/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider extends ChangeNotifier {
  Auth _auth = Auth();
  ApiService _apiService = ApiService();

  AuthProvider.instance() {
    checkLoggedIn();
  }

  String _failure;
  String get failure => _failure;
  void setFailure(String message) {
    _failure = failure;
    notifyListeners();
  }

  Status _status = Status.Uninitialized;
  Status get status => _status;
  void setStatus(Status status) {
    _status = status;
    notifyListeners();
  }

  String _userid;
  String getUserId() {
    return _userid;
  }

  void setUserId(String userid) {
    _userid = userid;
    notifyListeners();
  }

  void getToken() async{
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    await _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("ini token " + token);
    });
  }

  Future<bool> doLogin(String email, String password) {
    print("email1: $email");
    try {
      setStatus(Status.Authenticating);
      notifyListeners();
      return _apiService.postLogin(email, password).then((dynamic res) {
        print(res["uuid"]);
        if (res == null) {
          setStatus(Status.Unauthenticated);
          notifyListeners();

          return false;
        } else if (res["uuid"] != null) {
          print("uuid" + res["uuid"]);
          setUserId(res["uuid"]);
          //Getting the token from FCM
          getToken();
          notifyListeners();
          return true;
        } else {
          setStatus(Status.Unauthenticated);
          notifyListeners();

          return false;
        }
      });
    } catch (e) {
      setStatus(Status.Unauthenticated);
      notifyListeners();
    }
  }

  Future doLogout(BuildContext context) async {
    deleteToken();
    setStatus(Status.Unauthenticated);
    notifyListeners();
    return Navigator.popUntil(context, ModalRoute.withName(Router.initialPage));
  }

  Future saveToken(String userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uuid', '$userid');
    print("userId saved to local !");
    setStatus(Status.Authenticated);

    notifyListeners();
  }

  void deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uuid');
    print("userId deleted from local !");

    notifyListeners();
  }

  Future<void> checkLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var isUserid = prefs.getString('uuid');
      print(isUserid);
      if (isUserid == null) {
        setStatus(Status.Unauthenticated);
      } else {
        setStatus(Status.Authenticated);
      }
    } catch (error) {
      print("ini error: " + error.toString());

      setStatus(Status.Unauthenticated);
    }
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    setStatus(Status.Authenticating);
    notifyListeners();

    try {
      String userUid = await _auth.signUp(email, password);
      // String _token = getToken();
      // print("token again" + _token);

      print("Registered user: $userUid");
      return _apiService
          .postSignUp(email, password, userUid)
          .then((dynamic res) {
        print(res["status"]);
        if (res == null) {
          setStatus(Status.Unauthenticated);
          notifyListeners();

          return false;
        } else if (res["uuid"] != null) {
          print("resssss" + res["uuid"]);
          setUserId(res["uuid"]);

          notifyListeners();
          return true;
        } else {
          setStatus(Status.Unauthenticated);
          notifyListeners();

          return false;
        }
      });
    } on PlatformException {
      _status = Status.Unauthenticated;
      setFailure("Email sudah terdaftar");
      print("ini");

      notifyListeners();

      return null;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();

      print(Exception(e));
      return null;
    }
  }
}
