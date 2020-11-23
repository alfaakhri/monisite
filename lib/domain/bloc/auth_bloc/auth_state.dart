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
