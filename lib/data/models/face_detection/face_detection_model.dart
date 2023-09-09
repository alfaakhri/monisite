class FaceDetectionModel {
  int? currentPage;
  List<DataFaceDetection>? data;
  String? firstPageUrl;
  int? from;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;

  FaceDetectionModel(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to});

  FaceDetectionModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataFaceDetection>[];
      json['data'].forEach((v) {
        data!.add(new DataFaceDetection.fromJson(v));
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

class DataFaceDetection {
  int? id;
  int? siteId;
  String? userId;
  String? readerCode;
  String? name;
  String? image;
  String? recordTime;
  String? createdAt;
  String? updatedAt;

  DataFaceDetection(
      {this.id,
      this.siteId,
      this.userId,
      this.readerCode,
      this.name,
      this.image,
      this.recordTime,
      this.createdAt,
      this.updatedAt});

  DataFaceDetection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['site_id'];
    userId = json['user_id'];
    readerCode = json['reader_code'];
    name = json['name'];
    image = json['image'];
    recordTime = json['record_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_id'] = this.siteId;
    data['user_id'] = this.userId;
    data['reader_code'] = this.readerCode;
    data['name'] = this.name;
    data['image'] = this.image;
    data['record_time'] = this.recordTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
