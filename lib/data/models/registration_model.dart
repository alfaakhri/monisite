import 'dart:convert';

class RegistrationModel {
  final String nama;
  final String email;
  final String telepon;
  final String password;
  final String confirmPassword;
  final int role;
  RegistrationModel({
    required this.nama,
    required this.email,
    required this.telepon,
    required this.password,
    required this.confirmPassword,
    required this.role,
  });

  RegistrationModel copyWith({
    String? nama,
    String? email,
    String? telepon,
    String? password,
    String? confirmPassword,
    int? role,
  }) {
    return RegistrationModel(
      nama: nama ?? this.nama,
      email: email ?? this.email,
      telepon: telepon ?? this.telepon,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'email': email,
      'telepon': telepon,
      'password': password,
      'confirm_password': confirmPassword,
      'role': role,
    };
  }

  factory RegistrationModel.fromMap(Map<String, dynamic> map) {
    return RegistrationModel(
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      telepon: map['telepon'] ?? '',
      password: map['password'] ?? '',
      confirmPassword: map['confirm_password'] ?? '',
      role: map['role']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationModel.fromJson(String source) =>
      RegistrationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegistrationModel(nama: $nama, email: $email, telepon: $telepon, password: $password, confirmPassword: $confirmPassword, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegistrationModel &&
        other.nama == nama &&
        other.email == email &&
        other.telepon == telepon &&
        other.password == password &&
        other.confirmPassword == confirmPassword &&
        other.role == role;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
        email.hashCode ^
        telepon.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode ^
        role.hashCode;
  }
}
