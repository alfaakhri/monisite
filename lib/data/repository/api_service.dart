import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_monisite/core/components/Failure.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

const BASE_URL = "https://api.toragasolusi.com";

class ApiService {
  String clusterName = "Bekasi";
  final JsonDecoder _decoder = new JsonDecoder();
  Dio _dio = Dio();
  late Response response;

  Future<Response> getSitesNew(String token) async {
    print("TOKEN $token");
    try {
      final response = await _dio.get(BASE_URL + "/api/v1/site",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return e.response!;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> getSitesBySearch(String result, String token) async {
    print("TOKEN $token");
    try {
      final response = await _dio.get(BASE_URL + "/api/v1/site?search=$result",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<dynamic> fetchMonitor(String id, String token) async {
    try {
      final responseBody = await _dio
          .get(BASE_URL + "/api/v1/monitor?id=$id",
              options: Options(headers: {"Authorization": "Bearer $token"}))
          .then((response) {
        final String res = response.data;

        if (response.statusCode! < 200 || response.statusCode! > 400) {
          throw new Failure("Error while fetching data");
        }
        return _decoder.convert(res);
      });
      // final responseBody = await http.get(BASE_URL);
      return responseBody;
    } catch (e) {
      throw e;
    }
  }

  Future<Response?> getSiteByID(int id, String token) async {
    try {
      final response = await _dio.get(
          BASE_URL + "/api/v1/monitor?site_id=$id&last=true",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> getReportMonitor(
      int id, String fromDate, String toDate, String token) async {
    try {
      final response = await _dio.get(
          BASE_URL +
              "/api/v1/monitor?site_id=$id&from=$fromDate&to=$toDate&limit=-1",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> getReportListMonitor(int id, String fromDate, String toDate,
      String token, int pageIndex) async {
    try {
      final response = await _dio.get(
          BASE_URL +
              "/api/v1/monitor?site_id=$id&from=$fromDate&to=$toDate&limit=10&page=$pageIndex",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> getListNotification(String token) async {
    try {
      final response = await _dio.get(BASE_URL + "/api/v1/notification",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> postAcceptNotif(int notifId, String token) async {
    try {
      final response = await _dio.post(
          BASE_URL + "/api/v1/acceptNotif/$notifId",
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> postHistoryProcess(
      int notifId, int status, String token) async {
    try {
      final response = await _dio.post(BASE_URL + "/api/v1/fixNotif/$notifId",
          data: {"status": status},
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response> postLogin(String email, String password) async {
    try {
      response = await _dio.post(BASE_URL + "/api/v1/login",
          data: {"email": email, "password": password, "role": 1});

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response?> getAuthentication(String token) async {
    try {
      response = await _dio.get(BASE_URL + "/api/v1/profile",
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> addTokenFirebase(String token, String tokenFirebase) async {
    try {
      response = await _dio.post(BASE_URL + "/api/v1/addToken",
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: {"token": tokenFirebase});

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> updatePhotoProfile(String token, File data) async {
    try {
      var filename = '${Uuid().v1()}.jpg';
      MultipartFile multipartFile =
          await MultipartFile.fromFile(data.path, filename: filename);
      FormData formData = FormData.fromMap({"photo": multipartFile});

      response = await _dio.post(BASE_URL + "/api/v1/updatePhoto",
          options: Options(headers: {"Authorization": "Bearer $token"}),
          data: formData);

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> getLogout(String token) async {
    try {
      response = await _dio.post(BASE_URL + "/api/v1/logout",
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> postSignUp(dynamic data) async {
    try {
      response = await _dio.post(BASE_URL + "/api/v1/register", data: data);

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> updateUser(dynamic data, String token, int idUser) async {
    print("edit profil: " + data.toString());
    try {
      response = await _dio.put(BASE_URL + "/api/v1/user/$idUser",
          data: data,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return e.response;
      } else {
        throw e;
      }
    }
  }

  Future<Response?> updatePassword(String newPassword, String cPassword,
      String oldPassword, String token) async {
    var data = {
      "password": newPassword,
      "c_password": cPassword,
      "old_password": oldPassword
    };
    try {
      response = await _dio.put(BASE_URL + "/api/v1/updatePassword",
          data: data,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      return response;
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return e.response;
      } else {
        throw e;
      }
    }
  }
}
