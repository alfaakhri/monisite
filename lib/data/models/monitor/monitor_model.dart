class MonitorModel {
  bool? success;
  String? message;
  DataMonitor? data;

  MonitorModel({this.success, this.message, this.data});

  MonitorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new DataMonitor.fromJson(json['data']) : null;
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

class DataMonitor {
  int? id;
  int? siteId;
  int? alarmId;
  int? type;
  int? teganganRs;
  int? teganganRt;
  int? teganganSt;
  int? teganganRn;
  int? teganganSn;
  int? teganganTn;
  int? arusR;
  int? arusS;
  int? arusT;
  int? arusAc;
  int? temperature;
  int? pressure;
  String? createdAt;
  String? code;
  String? siteName;
  String? siteType;
  String? towerType;
  String? towerHeight;
  String? tenantOm;
  String? tp;
  String? latitude;
  String? longitude;
  String? address;
  int? clusterId;
  int? categoryId;
  int? btsId;
  String? categoryName;
  String? clusterName;
  String? btsPosition;

  DataMonitor(
      {this.id,
      this.siteId,
      this.alarmId,
      this.type,
      this.teganganRs,
      this.teganganRt,
      this.teganganSt,
      this.teganganRn,
      this.teganganSn,
      this.teganganTn,
      this.arusR,
      this.arusS,
      this.arusT,
      this.arusAc,
      this.temperature,
      this.pressure,
      this.createdAt,
      this.code,
      this.siteName,
      this.siteType,
      this.towerType,
      this.towerHeight,
      this.tenantOm,
      this.tp,
      this.latitude,
      this.longitude,
      this.address,
      this.clusterId,
      this.categoryId,
      this.btsId,
      this.categoryName,
      this.clusterName,
      this.btsPosition});

  DataMonitor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteId = json['site_id'];
    alarmId = json['alarm_id'];
    type = json['type'];
    teganganRs = json['tegangan_rs'];
    teganganRt = json['tegangan_rt'];
    teganganSt = json['tegangan_st'];
    teganganRn = json['tegangan_rn'];
    teganganSn = json['tegangan_sn'];
    teganganTn = json['tegangan_tn'];
    arusR = json['arus_r'];
    arusS = json['arus_s'];
    arusT = json['arus_t'];
    arusAc = json['arus_ac'];
    temperature = json['temperature'];
    pressure = json['pressure'];
    createdAt = json['created_at'];
    code = json['code'];
    siteName = json['site_name'];
    siteType = json['site_type'];
    towerType = json['tower_type'];
    towerHeight = json['tower_height'];
    tenantOm = json['tenant_om'];
    tp = json['tp'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    clusterId = json['cluster_id'];
    categoryId = json['category_id'];
    btsId = json['bts_id'];
    categoryName = json['category_name'];
    clusterName = json['cluster_name'];
    btsPosition = json['bts_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_id'] = this.siteId;
    data['alarm_id'] = this.alarmId;
    data['type'] = this.type;
    data['tegangan_rs'] = this.teganganRs;
    data['tegangan_rt'] = this.teganganRt;
    data['tegangan_st'] = this.teganganSt;
    data['tegangan_rn'] = this.teganganRn;
    data['tegangan_sn'] = this.teganganSn;
    data['tegangan_tn'] = this.teganganTn;
    data['arus_r'] = this.arusR;
    data['arus_s'] = this.arusS;
    data['arus_t'] = this.arusT;
    data['arus_ac'] = this.arusAc;
    data['temperature'] = this.temperature;
    data['pressure'] = this.pressure;
    data['created_at'] = this.createdAt;
    data['code'] = this.code;
    data['site_name'] = this.siteName;
    data['site_type'] = this.siteType;
    data['tower_type'] = this.towerType;
    data['tower_height'] = this.towerHeight;
    data['tenant_om'] = this.tenantOm;
    data['tp'] = this.tp;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['cluster_id'] = this.clusterId;
    data['category_id'] = this.categoryId;
    data['bts_id'] = this.btsId;
    data['category_name'] = this.categoryName;
    data['cluster_name'] = this.clusterName;
    data['bts_position'] = this.btsPosition;
    return data;
  }
}
