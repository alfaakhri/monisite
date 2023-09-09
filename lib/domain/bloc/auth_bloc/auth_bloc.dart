import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monisite/data/models/profile_model.dart';
import 'package:flutter_monisite/data/models/registration_model.dart';
import 'package:flutter_monisite/data/models/registration_response.dart';
import 'package:flutter_monisite/data/models/response_update_password.dart';
import 'package:flutter_monisite/data/models/token_model.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:flutter_monisite/external/service/firebase_service.dart';
import 'package:flutter_monisite/external/service/shared_preference_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SharedPreferenceService _sharedPreferenceService = SharedPreferenceService();
  ApiService _apiService = ApiService();
  FirebaseService _firebaseService = FirebaseService();

  TokenModel _tokenModel = TokenModel();
  TokenModel get tokenModel => _tokenModel;
  void setTokenModel(TokenModel tokenModel) {
    _tokenModel = tokenModel;
  }

  String? _token = '';
  String get token => _token ?? '';
  void setToken(String token) {
    _token = token;
  }

  String? _tokenFirebase = "";
  String get tokenFirebase => _tokenFirebase ?? "";
  void setTokenFirebase(String tokenFirebase) {
    _tokenFirebase = tokenFirebase;
  }

  ProfileModel _profileModel = ProfileModel();
  ProfileModel get profileModel => _profileModel;
  void setProfileModel(ProfileModel profileModel) {
    _profileModel = profileModel;
  }

  AuthBloc() : super(AuthInitial()) {
    on<GetAuthentication>((event, emit) async {
      emit(GetAuthLoading());
      try {
        _token = await _sharedPreferenceService.getToken();
        print("TOKEN $_token");
        if (_token == null) {
          emit(GetAuthFailed("Login terlebih dahulu"));
        } else {
          var response = await _apiService.getAuthentication(_token!);
          if (response?.statusCode == 200) {
            _tokenFirebase = await _firebaseService.getToken();
            print("TOKEN FIREBASE $_tokenFirebase");
            await _apiService
                .addTokenFirebase(_token!, _tokenFirebase!)
                .then((value) {
              _profileModel = ProfileModel.fromJson(response?.data);
            });
            emit(GetAuthSuccess(_profileModel));
          } else if (response?.statusCode == 401) {
            emit(GetAuthMustLogin());
          } else {
            emit(GetAuthFailed("Login terlebih dahulu"));
          }
        }
      } catch (error) {
        print("GetAuthFailed: " + error.toString());
        emit(GetAuthFailed(error.toString()));
      }
    });
    on<DoLogin>((event, emit) async {
      emit(DoLoginLoading());
      try {
        var response = await _apiService.postLogin(event.email, event.password);
        _tokenModel = TokenModel.fromJson(response!.data);

        if (response.statusCode == 200) {
          _sharedPreferenceService.saveToken(_tokenModel.token!);
          _tokenFirebase = await _firebaseService.getToken();
          print("TOKEN FIREBASE $_tokenFirebase");
          await _apiService.addTokenFirebase(
              _tokenModel.token!, _tokenFirebase!);
          emit(DoLoginSuccess());
        } else {
          emit(DoLoginFailed(_tokenModel.message!));
        }
      } catch (e) {
        emit(DoLoginFailed(e.toString()));
      }
    });
    on<DoLogout>((event, emit) async {
      var response = await _apiService.getLogout(token);
      if (response?.statusCode == 200) {
        _sharedPreferenceService.deleteTokenModel();
        _token = null;
        emit(DoLogoutSuccess());
      } else {
        emit(DoLogoutFailed());
      }
    });
    on<PostSignup>((event, emit) async {
      emit(PostSignupLoading());

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
        if (response?.statusCode == 200) {
          RegistrationResponse registration =
              RegistrationResponse.fromJson(response?.data);
          _sharedPreferenceService.saveToken(registration.token!);
          _tokenFirebase = await _firebaseService.getToken();
          print("TOKEN FIREBASE $_tokenFirebase");
          await _apiService.addTokenFirebase(
              registration.token!, _tokenFirebase!);
          emit(PostSignupSuccess());
        } else if (response?.statusCode == 422) {
          RegistrationResponse registration =
              RegistrationResponse.fromJson(response?.data);
          emit(PostSignupFailed(registration.email!.first));
        } else {
          emit(PostSignupFailed("Something wrong, please try again."));
        }
      } catch (e) {
        emit(PostSignupFailed(e.toString()));
      }
    });
    on<StartApp>((event, emit) {
      emit(GetAuthLoading());
      Timer(Duration(seconds: 2), () {
        add(GetAuthentication());
      });
    });
    on<EditProfile>((event, emit) async {
      emit(EditProfileLoading());

      try {
        var data = {
          'name': event.nama,
          'email': event.email,
          'phone_number': event.phonNumber,
          'address': event.address
        };
        var response = await _apiService.updateUser(
            json.encode(data), token, event.idUser);
        if (response?.statusCode == 200) {
          if (response?.data['success'] == true) {
            var response = await _apiService.getAuthentication(_token!);
            if (response?.statusCode == 200) {
              _tokenFirebase = await _firebaseService.getToken();
              print("TOKEN FIREBASE $_tokenFirebase");

              await _apiService.addTokenFirebase(_token!, _tokenFirebase!);
              _profileModel = ProfileModel.fromJson(response?.data);
              emit(EditProfileSuccess(_profileModel));
            } else if (response?.statusCode == 401) {
              emit(GetAuthMustLogin());
            } else {
              emit(GetAuthFailed("Login terlebih dahulu"));
            }
          } else {
            emit(EditProfileFailed("Ada sesuatu yang salah. Coba lagi :)"));
          }
        } else {
          emit(EditProfileFailed("Ada sesuatu yang salah. Coba lagi :)"));
        }
      } catch (e) {
        emit(EditProfileFailed(e.toString()));
      }
    });
    on<EditPhotoProfile>((event, emit) async {
      // File? image =
      //     await ImagePickerService().dialogImageEditProfil(event.context);

      // print('Image Path $image');

      // if (image != null) {
      //   print("Ukuran : " + image.lengthSync().toString());
      //   if (image.lengthSync() >= 5000000) {
      //     yield EditPhotoProfileMaxSize();
      //   }
      //   try {
      //     var response = await _apiService.updatePhotoProfile(token, image);
      //     if (response?.statusCode == 200) {
      //       var responseAuth = await _apiService.getAuthentication(_token!);
      //       if (responseAuth?.statusCode == 200) {
      //         _profileModel = ProfileModel.fromJson(responseAuth?.data);
      //         yield EditProfileSuccess(_profileModel);
      //       } else if (responseAuth?.statusCode == 401) {
      //         yield GetAuthMustLogin();
      //       } else {
      //         yield GetAuthFailed("Login terlebih dahulu");
      //       }
      //     } else {
      //       yield EditPhotoProfileFailed("Failed update photo profile");
      //     }
      //   } catch (e) {
      //     yield EditPhotoProfileFailed(e.toString());
      //   }
      // } else {
      //   yield EditPhotoProfileCancel();
      // }
    });
    on<ChangePassword>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        var tokenNew = await _sharedPreferenceService.getToken();
        if (tokenNew == null) {
          emit(GetAuthMustLogin());
        } else {
          _token = tokenNew;
          var response = await _apiService.updatePassword(
              event.newPassoword, event.cPassword, event.oldPassword, _token!);
          if (response?.statusCode == 200) {
            ResponseUpdatePassword responseUpdate = ResponseUpdatePassword();
            responseUpdate = ResponseUpdatePassword.fromJson(response?.data);
            if (responseUpdate.success ?? false) {
              emit(ChangePasswordMatch(responseUpdate));
            } else
              emit(ChangePasswordNotMatch(responseUpdate));
          } else {
            emit(ChangePasswordFailed(
                "Something wrong update password, try again"));
          }
        }
      } catch (e) {
        emit(ChangePasswordFailed(e.toString()));
      }
    });
  }
}
