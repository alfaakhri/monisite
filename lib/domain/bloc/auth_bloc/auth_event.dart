part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class GetAuthentication extends AuthEvent {}

class DoLogin extends AuthEvent {
  final String email;
  final String password;

  DoLogin(this.email, this.password);
}

class DoLogout extends AuthEvent {}

class PostSignup extends AuthEvent {
  final String nama;
  final String email;
  final String telepon;
  final String password;
  final String confirmPassword;

  PostSignup(
      this.nama, this.email, this.telepon, this.password, this.confirmPassword);
}

class StartApp extends AuthEvent {}
