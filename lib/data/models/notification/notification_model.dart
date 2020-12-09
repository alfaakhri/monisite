class NotificationModel {
  bool success;
  String message;
  List<DataNotification> data;

  NotificationModel({this.success, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<DataNotification>();
      json['data'].forEach((v) {
        data.add(new DataNotification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataNotification {
  int id;
  String body;
  String priority;
  int status;
  int siteId;
  int alarmId;
  String title;
  String fixingBy;
  String fixingTime;
  String createdAt;

  DataNotification(
      {this.id,
      this.body,
      this.priority,
      this.status,
      this.siteId,
      this.alarmId,
      this.title,
      this.fixingBy,
      this.fixingTime,
      this.createdAt});

  DataNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    priority = json['priority'];
    status = json['status'];
    siteId = json['site_id'];
    alarmId = json['alarm_id'];
    title = json['title'];
    fixingBy = json['fixing_by'];
    fixingTime = json['fixing_time'];
    createdAt = json['created_at'];
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
    data['fixing_by'] = this.fixingBy;
    data['fixing_time'] = this.fixingTime;
    data['created_at'] = this.createdAt;
    return data;
  }
}