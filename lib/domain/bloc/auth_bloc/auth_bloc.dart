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
          _sharedPreferenceService.saveToken(_tokenModel.token);
          yield DoLoginSuccess();
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
    }
  }

  Stream<AuthState> _startAppToState() async* {
    yield GetAuthLoading();
    Timer(Duration(seconds: 2), () {
      add(GetAuthentication());
    });
  }
}
