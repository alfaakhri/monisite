class Site {
  int id;
  String code;
  String siteName;
  String siteType;
  String towerType;
  String towerHeight;
  String tenantOm;
  String tp;
  String latitude;
  String longitude;
  String address;
  int clusterId;
  int categoryId;
  int btsId;
  String createdAt;
  String categoryName;
  String clusterName;
  String btsPosition;

  Site(
      {this.id,
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
      this.createdAt,
      this.categoryName,
      this.clusterName,
      this.btsPosition});

  Site.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    categoryName = json['category_name'];
    clusterName = json['cluster_name'];
    btsPosition = json['bts_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['created_at'] = this.createdAt;
    data['category_name'] = this.categoryName;
    data['cluster_name'] = this.clusterName;
    data['bts_position'] = this.btsPosition;
    return data;
  }
}