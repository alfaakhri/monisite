import 'dart:convert';

class SiteById {
  final int id;
  final String siteid;
  final String sitename;
  final String towertype;
  final String towertypeheight;
  final String tenantom;
  final String tp;
  final String latitude;
  final String longitude;
  final String address;
  final int clusterid;
  final int categoryid;
  final int btsid;
  final String clustername;
  final int parentclusterid;
  SiteById({
    required this.id,
    required this.siteid,
    required this.sitename,
    required this.towertype,
    required this.towertypeheight,
    required this.tenantom,
    required this.tp,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.clusterid,
    required this.categoryid,
    required this.btsid,
    required this.clustername,
    required this.parentclusterid,
  });

  

  factory SiteById.fromJson(Map<String, dynamic> json) {
    return SiteById(
        id: json['id'],
        siteid: json['site_id'],
        sitename: json['sitename'],
        towertype: json['towertype'],
        towertypeheight: json['towertypeheight'],
        tenantom: json['tenant_om'],
        tp: json['tp'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        address: json['address'],
        clusterid: json['cluster_id'],
        categoryid: json['category_id'],
        btsid: json['bts_id'],
        clustername: json['cluster_name'],
        parentclusterid: json['parentcluster_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "site_id": siteid,
      "sitename": sitename,
      "towertype": towertype,
      "towertypeheight": towertypeheight,
      "tenant_om": tenantom,
      "tp": tp,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
      "cluster_id": clusterid,
      "category_id": categoryid,
      "bts_id": btsid,
      "cluster_name": clustername,
      "parentcluster_id": parentclusterid
    };
  }

  @override
  String toString() {
    return 'Site{id: $id, site_id: $siteid, sitename: $sitename, towertype: $towertype, towertypeheight: $towertypeheight, tenant_om: $tenantom, tp: $tp, latitude: $latitude, longitude: $longitude, address: $address, cluster_id: $clusterid, category_id: $categoryid, bts_id: $btsid, cluster_name: $clustername, parentcluster_id: $parentclusterid}';
  }
}

List<SiteById> siteFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<SiteById>.from(data.map((item) => SiteById.fromJson(item)));
}

String siteToJson(SiteById data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
