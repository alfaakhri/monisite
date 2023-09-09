class RfidDetectionModel {
  int? currentPage;
  List<DataRfid>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;

  RfidDetectionModel(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to});

  RfidDetectionModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataRfid>[];
      json['data'].forEach((v) {
        data!.add(new DataRfid.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    return data;
  }
}

class DataRfid {
  int? id;
  String? readerCode;
  int? userId;
  int? siteId;
  String? name;
  String? recordTime;
  String? createdAt;
  String? updatedAt;

  DataRfid(
      {this.id,
      this.readerCode,
      this.userId,
      this.siteId,
      this.name,
      this.recordTime,
      this.createdAt,
      this.updatedAt});

  DataRfid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    readerCode = json['reader_code'];
    userId = json['user_id'];
    siteId = json['site_id'];
    name = json['name'];
    recordTime = json['record_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reader_code'] = this.readerCode;
    data['user_id'] = this.userId;
    data['site_id'] = this.siteId;
    data['name'] = this.name;
    data['record_time'] = this.recordTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
