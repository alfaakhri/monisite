
import 'package:flutter_monisite/data/models/site/site.dart';

class SiteByIdModel {
  bool? success;
  String? message;
  Site? data;

  SiteByIdModel({this.success, this.message, this.data});

  SiteByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Site.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}