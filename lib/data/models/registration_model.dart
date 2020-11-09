class RegistrationModel {
  final String nama;
  final String email;
  final String telepon;
  final String password;
  final String confirmPassword;
  final int role;

  RegistrationModel(
      {this.nama,
      this.email,
      this.telepon,
      this.password,
      this.confirmPassword,
      this.role});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.nama;
    data['email'] = this.email;
    data['phone_number'] = this.telepon;
    data['role'] = this.role;
    data['password'] = this.password;
    data['c_password'] = this.confirmPassword;
    return data;
  }
}
