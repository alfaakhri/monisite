class TokenModel {
  String? token;
  String? tokenType;
  String? expiresIn;
  bool? status;
  String? message;

  TokenModel(
      {this.token, this.tokenType, this.expiresIn, this.status, this.message});

  TokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
