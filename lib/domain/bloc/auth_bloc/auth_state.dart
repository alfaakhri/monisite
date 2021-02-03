part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class GetAuthLoading extends AuthState {}

class GetAuthSuccess extends AuthState {
  final ProfileModel profileModel;

  GetAuthSuccess(this.profileModel);
}

class GetAuthFailed extends AuthState {
  final String message;

  GetAuthFailed(this.message);
}

class GetAuthMustLogin extends AuthState {}

class DoLoginLoading extends AuthState {}

class DoLoginSuccess extends AuthState {}

class DoLoginFailed extends AuthState {
  final String message;

  DoLoginFailed(this.message);
}

class DoLogoutSuccess extends AuthState {}

class DoLogoutFailed extends AuthState {}

class PostSignupLoading extends AuthState {}

class PostSignupSuccess extends AuthState {}

class PostSignupFailed extends AuthState {
  final String message;

  PostSignupFailed(this.message);
}

class AddTokenSuccess extends AuthState {}

class AddTokenFailed extends AuthState {}

class EditProfileLoading extends AuthState {}

class EditProfileSuccess extends AuthState {
  final ProfileModel profileModel;

  EditProfileSuccess(this.profileModel);
}

class EditProfileFailed extends AuthState {
  final String message;
  EditProfileFailed(this.message);
}

class EditPhotoProfileLoading extends AuthState {}
class EditPhotoProfileSuccess extends AuthState {
  final ProfileModel profileModel;

  EditPhotoProfileSuccess(this.profileModel);
}
class EditPhotoProfileCancel extends AuthState {}
class EditPhotoProfileFailed extends AuthState {
  final String message;

  EditPhotoProfileFailed(this.message);
}

class EditPhotoProfileMaxSize extends AuthState {}

class ChangePasswordLoading extends AuthState {}
class ChangePasswordMatch extends AuthState {
  final ResponseUpdatePassword response;

  ChangePasswordMatch(this.response);
}

class ChangePasswordNotMatch extends AuthState {
  final ResponseUpdatePassword response;

  ChangePasswordNotMatch(this.response);
}

class ChangePasswordFailed extends AuthState {
  final String message;

  ChangePasswordFailed(this.message);
}
