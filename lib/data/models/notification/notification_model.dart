class NotificationModel {
  bool? success;
  String? message;
  List<DataNotification>? data;

  NotificationModel({this.success, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new DataNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataNotification {
  int? id;
  String? body;
  String? priority;
  int? status;
  int? siteId;
  int? alarmId;
  String? title;
  String? acceptTime;
  int? fixingBy;
  String? fixingTime;
  String? createdAt;
  String? code;
  String? siteName;
  String? address;
  String? tenantOm;
  String? tp;
  String? latitude;
  String? longitude;

  DataNotification(
      {this.id,
      this.body,
      this.priority,
      this.status,
      this.siteId,
      this.alarmId,
      this.title,
      this.acceptTime,
      this.fixingBy,
      this.fixingTime,
      this.createdAt,
      this.code,
      this.siteName,
      this.address,
      this.tenantOm,
      this.tp,
      this.latitude,
      this.longitude});

  DataNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    priority = json['priority'];
    status = json['status'];
    siteId = json['site_id'];
    alarmId = json['alarm_id'];
    title = json['title'];
    acceptTime = json['accept_time'];
    fixingBy = json['fixing_by'];
    fixingTime = json['fixing_time'];
    createdAt = json['created_at'];
    code = json['code'];
    siteName = json['site_name'];
    address = json['address'];
    tenantOm = json['tenant_om'];
    tp = json['tp'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['site_id'] = this.siteId;
    data['alarm_id'] = this.alarmId;
    data['title'] = this.title;
    data['accept_time'] = this.acceptTime;
    data['fixing_by'] = this.fixingBy;
    data['fixing_time'] = this.fixingTime;
    data['created_at'] = this.createdAt;
    data['code'] = this.code;
    data['site_name'] = this.siteName;
    data['address'] = this.address;
    data['tenant_om'] = this.tenantOm;
    data['tp'] = this.tp;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
