class ProfileModel {
  User user;

  ProfileModel({this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String email;
  String name;
  int role;
  String address;
  String phoneNumber;
  String photo;
  String token;
  String createdAt;
  String updatedAt;
  String emailVerifiedAt;
  String photoUrl;

  User(
      {this.id,
      this.email,
      this.name,
      this.role,
      this.address,
      this.phoneNumber,
      this.photo,
      this.token,
      this.createdAt,
      this.updatedAt,
      this.emailVerifiedAt,
      this.photoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    token = json['token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    emailVerifiedAt = json['email_verified_at'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['role'] = this.role;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['photo'] = this.photo;
    data['token'] = this.token;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}