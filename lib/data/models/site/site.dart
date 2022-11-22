import 'dart:convert';

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
  Site({
    required this.id,
    required this.code,
    required this.siteName,
    required this.siteType,
    required this.towerType,
    required this.towerHeight,
    required this.tenantOm,
    required this.tp,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.clusterId,
    required this.categoryId,
    required this.btsId,
    required this.createdAt,
    required this.categoryName,
    required this.clusterName,
    required this.btsPosition,
  });

  

  Site copyWith({
    int? id,
    String? code,
    String? siteName,
    String? siteType,
    String? towerType,
    String? towerHeight,
    String? tenantOm,
    String? tp,
    String? latitude,
    String? longitude,
    String? address,
    int? clusterId,
    int? categoryId,
    int? btsId,
    String? createdAt,
    String? categoryName,
    String? clusterName,
    String? btsPosition,
  }) {
    return Site(
      id: id ?? this.id,
      code: code ?? this.code,
      siteName: siteName ?? this.siteName,
      siteType: siteType ?? this.siteType,
      towerType: towerType ?? this.towerType,
      towerHeight: towerHeight ?? this.towerHeight,
      tenantOm: tenantOm ?? this.tenantOm,
      tp: tp ?? this.tp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      clusterId: clusterId ?? this.clusterId,
      categoryId: categoryId ?? this.categoryId,
      btsId: btsId ?? this.btsId,
      createdAt: createdAt ?? this.createdAt,
      categoryName: categoryName ?? this.categoryName,
      clusterName: clusterName ?? this.clusterName,
      btsPosition: btsPosition ?? this.btsPosition,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'site_name': siteName,
      'site_type': siteType,
      'tower_type': towerType,
      'tower_height': towerHeight,
      'tenant_om': tenantOm,
      'tp': tp,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'cluster_id': clusterId,
      'category_id': categoryId,
      'bts_id': btsId,
      'created_at': createdAt,
      'category_name': categoryName,
      'cluster_name': clusterName,
      'bts_position': btsPosition,
    };
  }

  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      id: map['id']?.toInt() ?? 0,
      code: map['code'] ?? '',
      siteName: map['site_name'] ?? '',
      siteType: map['site_type'] ?? '',
      towerType: map['tower_type'] ?? '',
      towerHeight: map['tower_height'] ?? '',
      tenantOm: map['tenant_om'] ?? '',
      tp: map['tp'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      address: map['address'] ?? '',
      clusterId: map['cluster_id']?.toInt() ?? 0,
      categoryId: map['category_id']?.toInt() ?? 0,
      btsId: map['bts_id']?.toInt() ?? 0,
      createdAt: map['created_at'] ?? '',
      categoryName: map['category_name'] ?? '',
      clusterName: map['cluster_name'] ?? '',
      btsPosition: map['bts_position'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Site.fromJson(String source) => Site.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Site(id: $id, code: $code, siteName: $siteName, siteType: $siteType, towerType: $towerType, towerHeight: $towerHeight, tenantOm: $tenantOm, tp: $tp, latitude: $latitude, longitude: $longitude, address: $address, clusterId: $clusterId, categoryId: $categoryId, btsId: $btsId, createdAt: $createdAt, categoryName: $categoryName, clusterName: $clusterName, btsPosition: $btsPosition)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Site &&
      other.id == id &&
      other.code == code &&
      other.siteName == siteName &&
      other.siteType == siteType &&
      other.towerType == towerType &&
      other.towerHeight == towerHeight &&
      other.tenantOm == tenantOm &&
      other.tp == tp &&
      other.latitude == latitude &&
      other.longitude == longitude &&
      other.address == address &&
      other.clusterId == clusterId &&
      other.categoryId == categoryId &&
      other.btsId == btsId &&
      other.createdAt == createdAt &&
      other.categoryName == categoryName &&
      other.clusterName == clusterName &&
      other.btsPosition == btsPosition;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      code.hashCode ^
      siteName.hashCode ^
      siteType.hashCode ^
      towerType.hashCode ^
      towerHeight.hashCode ^
      tenantOm.hashCode ^
      tp.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      address.hashCode ^
      clusterId.hashCode ^
      categoryId.hashCode ^
      btsId.hashCode ^
      createdAt.hashCode ^
      categoryName.hashCode ^
      clusterName.hashCode ^
      btsPosition.hashCode;
  }
}
