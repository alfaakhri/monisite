import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_monisite/core/components/Failure.dart';
import 'package:flutter_monisite/core/models/Site.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

const BASE_URL = "https://ci-monisite.herokuapp.com/index.php";
const SITE_URL = "https://ci-monisite.herokuapp.com/index.php/site";
const LOGIN_URL = "http://ci-monisite.herokuapp.com/index.php/login";

class ApiService {
  String clusterName = "Bekasi";
  final JsonDecoder _decoder = new JsonDecoder();

  Future<List<Site>> getSites() async {
    final response = await http.get(SITE_URL + "?cluster=$clusterName");
    if (response.statusCode == 200) {
      print(response.statusCode);
      return siteFromJson(response.body);
    } else {
      return null;
    }
  }

  @override
  Future<dynamic> fetchSites() async {
    try {
      final responseBody = await http
          .get(SITE_URL + "?cluster=$clusterName")
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;

        print("res: " + res + " statusCode: " + statusCode.toString());
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Failure("Error while fetching data");
        }
        return _decoder.convert(res);
      });
      // final responseBody = await http.get(BASE_URL);
      return responseBody;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  Future<dynamic> fetchMonitor(String id) async {
    try {
      final responseBody = await http
          .get(BASE_URL + "/sensor/index_get?id=$id")
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;

        print("res: " + res + " statusCode: " + statusCode.toString());
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Failure("Error while fetching data");
        }
        return _decoder.convert(res);
      });
      // final responseBody = await http.get(BASE_URL);
      return responseBody;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  Future<dynamic> getSiteById(String id) async {
    try {
      final responseBody = await http
          .get(BASE_URL + "/site/index_get?id=$id")
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;

        print("res: " + res + " statusCode: " + statusCode.toString());
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Failure("Error while fetching data");
        }
        return _decoder.convert(res);
      });
      // final responseBody = await http.get(BASE_URL);
      return responseBody;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  Future<dynamic> postLogin(String email, String password) async {
    print("email+password: " + email + "+" + password);
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String _token;

    //Getting the token from FCM
    await _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("ini token " + token);
      _token = token;
    });

    try {
      return await http
          .post(LOGIN_URL, body: {"email": email, "password": password, "token": _token}).then(
              (http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;

        print("res: " + res + " statusCode: " + statusCode.toString());
        if (statusCode < 200 || statusCode > 400 || json == null) {
          return _decoder.convert(res);
        }
        return _decoder.convert(res);
      });
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  Future<dynamic> postSignUp(
      String email, String password, String userid) async {
    print("email+password: " + email + "+" + password);
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String _token;

    //Getting the token from FCM
    await _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("ini token " + token);
      _token = token;
    });

    try {
      return http.post(BASE_URL + "/auth", body: {
        "email": email,
        "password": password,
        "uuid": userid,
        "token": _token
      }).then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;

        print("res: " + res + " statusCode: " + statusCode.toString());
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("error while fetching data");
        }
        return _decoder.convert(res);
      });
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    } on PlatformException {
      throw Failure("Email sudah terdaftar");
    }
  }

  Future<dynamic> getHistoryProccess() {
    try {
      // final responseBody = await http
      //     .get(BASE_URL + "/sensor/index_get?id=$id")
      //     .then((http.Response response) {
      //   final String res = response.body;
      //   final int statusCode = response.statusCode;

      //   print("res: " + res + " statusCode: " + statusCode.toString());
      //   if (statusCode < 200 || statusCode > 400 || json == null) {
      //     throw new Failure("Error while fetching data");
      //   }
      //   return _decoder.convert(res);
      // });
      // return responseBody;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  Future<dynamic> getHistoryFinished() {
    try {
      // final responseBody = await http
      //     .get(BASE_URL + "/sensor/index_get?id=$id")
      //     .then((http.Response response) {
      //   final String res = response.body;
      //   final int statusCode = response.statusCode;

      //   print("res: " + res + " statusCode: " + statusCode.toString());
      //   if (statusCode < 200 || statusCode > 400 || json == null) {
      //     throw new Failure("Error while fetching data");
      //   }
      //   return _decoder.convert(res);
      // });
      // return responseBody;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }

  Future<dynamic> acceptNotification() {
    try {
      // final responseBody = await http
      //     .get(BASE_URL + "/sensor/index_get?id=$id")
      //     .then((http.Response response) {
      //   final String res = response.body;
      //   final int statusCode = response.statusCode;

      //   print("res: " + res + " statusCode: " + statusCode.toString());
      //   if (statusCode < 200 || statusCode > 400 || json == null) {
      //     throw new Failure("Error while fetching data");
      //   }
      //   return _decoder.convert(res);
      // });
      // return responseBody;
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    }
  }
}
