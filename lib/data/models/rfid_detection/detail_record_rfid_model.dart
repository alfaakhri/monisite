class DetailRecordRFIDModel {
  bool? success;
  String? message;
  DataDetail? data;

  DetailRecordRFIDModel({this.success, this.message, this.data});

  DetailRecordRFIDModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DataDetail.fromJson(json['data']) : null;
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

class DataDetail {
  int? id;
  String? name;
  List<RecordsRFID>? records;

  DataDetail({this.id, this.name, this.records});

  DataDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['records'] != null) {
      records = <RecordsRFID>[];
      json['records'].forEach((v) {
        records!.add(new RecordsRFID.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecordsRFID {
  int? id;
  String? rfidCode;
  int? siteId;
  String? recordTime;
  String? createdAt;
  String? updatedAt;

  RecordsRFID(
      {this.id,
      this.rfidCode,
      this.siteId,
      this.recordTime,
      this.createdAt,
      this.updatedAt});

  RecordsRFID.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rfidCode = json['rfid_code'];
    siteId = json['site_id'];
    recordTime = json['record_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rfid_code'] = this.rfidCode;
    data['site_id'] = this.siteId;
    data['record_time'] = this.recordTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
