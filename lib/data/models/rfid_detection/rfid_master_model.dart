class RFIDMasterModel {
  int? currentPage;
  List<DataRFIDMaster>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;

  RFIDMasterModel(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to});

  RFIDMasterModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataRFIDMaster>[];
      json['data'].forEach((v) {
        data!.add(new DataRFIDMaster.fromJson(v));
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

class DataRFIDMaster {
  int? id;
  String? code;
  String? name;
  int? siteId;
  String? createdAt;
  String? updatedAt;
  bool? status;

  DataRFIDMaster(
      {this.id,
      this.code,
      this.name,
      this.siteId,
      this.createdAt,
      this.updatedAt,
      this.status});

  DataRFIDMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    siteId = json['site_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['site_id'] = this.siteId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}