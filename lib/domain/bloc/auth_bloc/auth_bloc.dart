import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_monisite/data/models/profile_model.dart';
import 'package:flutter_monisite/data/models/registration_model.dart';
import 'package:flutter_monisite/data/models/registration_response.dart';
import 'package:flutter_monisite/data/models/token_model.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:flutter_monisite/external/service/firebase_service.dart';
import 'package:flutter_monisite/external/service/shared_preference_service.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
  ApiService _apiService = ApiService();
  FirebaseService _firebaseService = FirebaseService();

  TokenModel _tokenModel = TokenModel();
  TokenModel get tokenModel => _tokenModel;
  void setTokenModel(TokenModel tokenModel) {
    _tokenModel = tokenModel;
  }

  String _token;
  String get token => _token;
  void setToken(String token) {
    _token = token;
  }

  String _tokenFirebase;
  String get tokenFirebase => _tokenFirebase;
  void setTokenFirebase(String tokenFirebase) {
    _tokenFirebase = tokenFirebase;
  }

  ProfileModel _profileModel = ProfileModel();
  ProfileModel get profileModel => _profileModel;
  void setProfileModel(ProfileModel profileModel) {
    _profileModel = profileModel;
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GetAuthentication) {
      yield GetAuthLoading();

      try {
        _token = await _sharedPreferenceService.getToken();
        print("TOKEN $_token");
        if (_token == null) {
          yield GetAuthFailed("Login terlebih dahulu");
        } else {
          var response = await _apiService.getAuthentication(_token);
          if (response.statusCode == 200) {
            _tokenFirebase = await _firebaseService.getToken();
            print("TOKEN FIREBASE $_tokenFirebase");
            var responseToken =
                await _apiService.addTokenFirebase(_token, _tokenFirebase);
            _profileModel = ProfileModel.fromJson(response.data);
            yield GetAuthSuccess(_profileModel);
          } else if (response.statusCode == 401) {
            yield GetAuthMustLogin();
          } else {
            yield GetAuthFailed("Login terlebih dahulu");
          }
        }
      } catch (error) {
        print("GetAuthFailed: " + error.toString());
        yield GetAuthFailed(error.toString());
      }
    } else if (event is DoLogin) {
      yield DoLoginLoading();
      try {
        var response = await _apiService.postLogin(event.email, event.password);
        if (response.statusCode == 200) {
          _tokenModel = TokenModel.fromJson(response.data);
          if (_tokenModel.success == false) {
            yield DoLoginFailed("Email atau password salah");
          } else {
            _sharedPreferenceService.saveToken(_tokenModel.token);
            _tokenFirebase = await _firebaseService.getToken();
            print("TOKEN FIREBASE $_tokenFirebase");
            var responseToken = await _apiService.addTokenFirebase(
                _tokenModel.token, _tokenFirebase);
            yield DoLoginSuccess();
          }
        } else {
          yield DoLoginFailed("");
        }
      } catch (e) {
        yield DoLoginFailed(e.toString());
      }
    } else if (event is DoLogout) {
      var response = await _apiService.getLogout(token);
      if (response.statusCode == 200) {
        _sharedPreferenceService.deleteTokenModel();
        _token = null;
        yield DoLogoutSuccess();
      } else {
        yield DoLogoutFailed();
      }
    } else if (event is PostSignup) {
      yield PostSignupLoading();

      try {
        var data = RegistrationModel(
            nama: event.nama,
            email: event.email,
            telepon: event.telepon,
            password: event.password,
            confirmPassword: event.password,
            role: 1);
        print(data.toJson());

        var response = await _apiService.postSignUp(json.encode(data.toJson()));
        if (response.statusCode == 200) {
          RegistrationResponse registration =
              RegistrationResponse.fromJson(response.data);
          _sharedPreferenceService.saveToken(registration.token);
          _tokenFirebase = await _firebaseService.getToken();
          print("TOKEN FIREBASE $_tokenFirebase");
          var responseToken = await _apiService.addTokenFirebase(
              registration.token, _tokenFirebase);
          yield PostSignupSuccess();
        } else if (response.statusCode == 422) {
          RegistrationResponse registration =
              RegistrationResponse.fromJson(response.data);
          yield PostSignupFailed(registration.email.first);
        } else {
          yield PostSignupFailed("Something wrong, please try again.");
        }
      } catch (e) {
        yield PostSignupFailed(e.toString());
      }
    } else if (event is StartApp) {
      yield* _startAppToState();
    } else if (event is EditProfile) {
      yield EditProfileLoading();

      try {
        var data = {
          'name': event.nama,
          'email': event.email,
          'phone_number': event.phonNumber,
          'address': event.address
        };
        var response = await _apiService.updateUser(json.encode(data), token, event.idUser);
        if (response.statusCode == 200) {
          if (response.data['success'] == true) {
            var response = await _apiService.getAuthentication(_token);
            if (response.statusCode == 200) {
              _tokenFirebase = await _firebaseService.getToken();
              print("TOKEN FIREBASE $_tokenFirebase");
              var responseToken =
                  await _apiService.addTokenFirebase(_token, _tokenFirebase);
              _profileModel = ProfileModel.fromJson(response.data);
              yield EditProfileSuccess(_profileModel);
            } else if (response.statusCode == 401) {
              yield GetAuthMustLogin();
            } else {
              yield GetAuthFailed("Login terlebih dahulu");
            }
          } else {
            yield EditProfileFailed("Ada sesuatu yang salah. Coba lagi :)");
          }
        } else {
          yield EditProfileFailed("Ada sesuatu yang salah. Coba lagi :)");
        }
      } catch (e) {
        yield EditProfileFailed(e.toString());
      }
    }
  }

  Stream<AuthState> _startAppToState() async* {
    yield GetAuthLoading();
    Timer(Duration(seconds: 2), () {
      add(GetAuthentication());
    });
  }
}
