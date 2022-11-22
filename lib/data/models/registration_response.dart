class RegistrationResponse {
  Data? data;
  String? token;
  String? tokenType;
  int? expiresIn;
  List? email;
  List? password;
  List? cPassword;

  RegistrationResponse({this.data, this.token, this.tokenType});

  RegistrationResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'] != null ? json['expires_in'] : null;
    email = json['email'];
    password = json['password'];
    cPassword = json['c_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['email'] = this.email;
    data['password'] = this.password;
    data['c_password'] = this.cPassword;
    return data;
  }
}

class Data {
  String? name;
  String? email;
  String? phoneNumber;
  int? role;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.name,
      this.email,
      this.phoneNumber,
      this.role,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    role = json['role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['role'] = this.role;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
