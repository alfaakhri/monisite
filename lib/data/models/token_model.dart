class TokenModel {
  String token;
  String tokenType;
  int expiresIn;

  TokenModel({this.token, this.tokenType, this.expiresIn});

  TokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}