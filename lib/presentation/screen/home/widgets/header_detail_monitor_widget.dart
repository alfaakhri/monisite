import 'package:flutter/material.dart';
import 'package:flutter_monisite/presentation/screen/face_detection/list_face_detection_screen.dart';
import 'package:flutter_monisite/presentation/screen/home/widgets/icon_text_menu_widget.dart';
import 'package:flutter_monisite/presentation/screen/rfid_detection/list_rfid_master_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/monitor/monitor_model.dart';
import '../../../../external/ui_helpers.dart';
import '../map_screen.dart';

class HeaderDetailMonitorWidget extends StatelessWidget {
  final String status;
  final MonitorModel monitor;
  const HeaderDetailMonitorWidget(
      {super.key, required this.status, required this.monitor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              "Status: $status",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: (status == "Stabil")
                  ? Colors.green
                  : (status == "In Progress")
                      ? Colors.yellow
                      : (status == "Belum Terpasang")
                          ? Colors.grey
                          : Colors.red,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: (status == "Stabil")
                      ? Colors.green
                      : (status == "In Progress")
                          ? Colors.yellow
                          : (status == "Belum Terpasang")
                              ? Colors.grey
                              : Colors.red),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(monitor.data?.siteName ?? "",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ),
              UIHelper.verticalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time, color: Colors.white, size: 20),
                      UIHelper.horizontalSpaceVerySmall,
                      Container(
                          child: Text(
                              "Waktu Terbaru: ${DateFormat("dd MMM yyyy HH:mm:ss").format(DateTime.parse(monitor.data!.createdAt!).toLocal())}",
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  UIHelper.verticalSpaceVerySmall,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.text_snippet, color: Colors.white, size: 20),
                      UIHelper.horizontalSpaceVerySmall,
                      Container(
                          child: Text("Kode: ${monitor.data?.code ?? ""}",
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  UIHelper.verticalSpaceVerySmall,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.cloud, color: Colors.white, size: 20),
                      UIHelper.horizontalSpaceVerySmall,
                      Container(
                        child: Text(
                            "Tenant OM: ${monitor.data?.tenantOm ?? ""}",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceVerySmall,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.place, color: Colors.white, size: 20),
                      UIHelper.horizontalSpaceVerySmall,
                      Expanded(
                        child: Container(
                            child: Text(monitor.data?.address ?? "",
                                maxLines: 3,
                                style: TextStyle(color: Colors.white))),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconTextMenuWidget(
                          onTap: () {
                            var lat =
                                monitor.data!.latitude!.replaceAll(',', '.');
                            var long =
                                monitor.data!.longitude!.replaceAll(',', '.');

                            var route = new MaterialPageRoute(
                              builder: (BuildContext context) => MapScreen(
                                latitude: "$lat",
                                longitude: "$long",
                                sitename: "${monitor.data?.siteName ?? ""}",
                              ),
                            );
                            Navigator.of(context).push(route);
                          },
                          icon: Icons.map,
                          title: "Maps"),
                      IconTextMenuWidget(
                          onTap: () {
                            Get.to(ListRFIDMasterScreen(siteId: monitor.data?.siteId ?? 0,));
                          },
                          icon: Icons.edgesensor_high,
                          title: "RFID"),
                      IconTextMenuWidget(
                          onTap: () {
                            Get.to(ListFaceDetectionScreen(siteId: monitor.data?.siteId ?? 0,));
                          },
                          icon: Icons.face_6,
                          title: "Face Detection"),
                      IconTextMenuWidget(
                          onTap: () {},
                          icon: Icons.bar_chart,
                          title: "Laporan"),
                    ],
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
            ],
          ),
        ],
      ),
    );
  }
}
