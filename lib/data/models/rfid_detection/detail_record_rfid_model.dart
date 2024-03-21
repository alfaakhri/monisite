class RFIDRecordModel {
  int? id;
  String? code;
  int? siteId;
  String? name;
  String? recordTime;
  String? createdAt;
  String? updatedAt;

  RFIDRecordModel(
      {this.id,
      this.code,
      this.siteId,
      this.name,
      this.recordTime,
      this.createdAt,
      this.updatedAt});

  RFIDRecordModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    siteId = json['site_id'];
    name = json['name'];
    recordTime = json['record_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['site_id'] = this.siteId;
    data['name'] = this.name;
    data['record_time'] = this.recordTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  static List<RFIDRecordModel>? fromJsonList(jsonList) {
    return jsonList.map<RFIDRecordModel>((obj) => RFIDRecordModel.fromJson(obj)).toList();
  }
}
