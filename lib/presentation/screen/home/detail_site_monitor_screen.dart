import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/monitor/monitor_model.dart';
import 'package:flutter_monisite/domain/bloc/site_bloc/site_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/screen/report/report_screen.dart';
import 'package:flutter_monisite/presentation/widgets/container_sensor.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:intl/intl.dart';

import 'map_screen.dart';

class DetailSiteMonitorScreen extends StatefulWidget {
  final int siteID;

  const DetailSiteMonitorScreen({Key key, this.siteID}) : super(key: key);
  @override
  _DetailSiteMonitorScreenState createState() =>
      _DetailSiteMonitorScreenState();
}

class _DetailSiteMonitorScreenState extends State<DetailSiteMonitorScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  SiteBloc siteBloc;

  @override
  void initState() {
    super.initState();
    siteBloc = BlocProvider.of<SiteBloc>(context);
    siteBloc.add(GetSiteByID(widget.siteID));
  }

  Widget buildCtn() {
    return BlocConsumer<SiteBloc, SiteState>(
      listener: (context, state) {
        if (state is GetSiteByIDFailed) {
          Fluttertoast.showToast(msg: state.message);
        }
      },
      builder: (context, state) {
        if (state is GetSiteByIDLoading) {
          return _skeletonLoading();
        } else if (state is GetSiteByIDSuccess) {
          return _buildDetailHomeScreen(state.dataMonitor, siteBloc.status);
        } else if (state is GetSiteByIDEmpty) {
          return ErrorHandlingWidget(
              icon: "images/laptop.png",
              title: state.message,
              subTitle: "Silahkan kembali dalam beberapa saat lagi.");
        } else if (state is GetSiteByIDFailed) {
          return ErrorHandlingWidget(
              icon: "images/laptop.png",
              title: state.message,
              subTitle: "Silahkan kembali dalam beberapa saat lagi.");
        }
        return _skeletonLoading();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        siteBloc.add(GetSites());
        //trigger leaving and use own data
        Get.back();
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: ColorHelpers.colorBackground,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              siteBloc.add(GetSites());
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullUp: false,
            child: buildCtn(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              completeDuration: Duration(milliseconds: 500),
            ),
            header: WaterDropMaterialHeader(
                backgroundColor: Colors.white.withOpacity(0.8),
                color: Colors.blue),
            onRefresh: () async {
              //monitor fetch data from network
              await Future.delayed(Duration(milliseconds: 1000));

              siteBloc.add(GetSiteByID(widget.siteID));

              if (mounted) setState(() {});
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              //monitor fetch data from network
              await Future.delayed(Duration(milliseconds: 1000));
//        for (int i = 0; i < 10; i++) {
//          data.add("Item $i");
//        }
              if (mounted) setState(() {});
              _refreshController.loadFailed();
            },
          ),
        ),
      ),
    );
  }

  Widget _skeletonLoading() {
    return SkeletonAnimation(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: 85,
                  height: 25,
                  decoration: BoxDecoration(
                    color: ColorHelpers.colorGrey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        width: 250,
                        height: 35,
                        decoration: BoxDecoration(
                          color: ColorHelpers.colorGrey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.text_snippet,
                                color: Colors.white, size: 20),
                            UIHelper.horizontalSpaceVerySmall,
                            Container(
                              width: 150,
                              height: 10,
                              decoration: BoxDecoration(
                                color: ColorHelpers.colorGrey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.cloud, color: Colors.white, size: 20),
                            UIHelper.horizontalSpaceVerySmall,
                            Container(
                              width: 150,
                              height: 10,
                              decoration: BoxDecoration(
                                color: ColorHelpers.colorGrey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(15),
                              ),
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
                                width: 150,
                                height: 25,
                                decoration: BoxDecoration(
                                  color:
                                      ColorHelpers.colorGrey.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            )
                          ],
                        ),
                        UIHelper.verticalSpaceMedium,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(15.0),
              color: ColorHelpers.colorBackground,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: ColorHelpers.colorGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ]))
        ],
      ),
    ));
  }

  Widget _buildDetailHomeScreen(MonitorModel monitor, String status) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
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
                        child: Text(monitor.data.siteName,
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
                              Icon(Icons.access_time,
                                  color: Colors.white, size: 20),
                              UIHelper.horizontalSpaceVerySmall,
                              Container(
                                  child: Text("Waktu Terbaru: ${DateTime.parse(monitor.data.createdAt).toLocal().toString().split(".")[0]}",
                                      style: TextStyle(color: Colors.white))),
                            ],
                          ),
                          UIHelper.verticalSpaceVerySmall,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.text_snippet,
                                  color: Colors.white, size: 20),
                              UIHelper.horizontalSpaceVerySmall,
                              Container(
                                  child: Text("Site ID: ${monitor.data.siteId}",
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
                                    "Tenant OM: ${monitor.data.tenantOm}",
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
                                    child: Text(monitor.data.address,
                                        maxLines: 3,
                                        style: TextStyle(color: Colors.white))),
                              ),
                            ],
                          ),
                          UIHelper.verticalSpaceMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      var lat = monitor.data.latitude
                                          .replaceAll(',', '.');
                                      var long = monitor.data.longitude
                                          .replaceAll(',', '.');

                                      var route = new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MapScreen(
                                          latitude: "$lat",
                                          longitude: "$long",
                                          sitename: "${monitor.data.siteName}",
                                        ),
                                      );
                                      Navigator.of(context).push(route);
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.7),
                                      child: Icon(
                                        Icons.map,
                                        size: 30,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpaceVerySmall,
                                  Text(
                                    "Maps",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(ReportScreen(
                                          siteId: monitor.data.siteId));
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.7),
                                      child: Icon(
                                        Icons.bar_chart,
                                        size: 30,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpaceVerySmall,
                                  Text(
                                    "Laporan",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                    ],
                  ),
                ],
              ),
            ),
            columnDataUnit(monitor),
          ],
        ),
      ),
    );
  }

  Widget columnDataUnit(MonitorModel monitor) {
    return Container(
      padding: EdgeInsets.all(15.0),
      color: ColorHelpers.colorBackground,
      child: Column(
        children: <Widget>[
          // (monitor.data != null)
          //     ? Text("Alat sensor belum terpasang !")
          //     : Text(''),
          ContainerSensor(
            iconData: Icons.ac_unit,
            title: 'Suhu',
            data:
                (monitor.data != null) ? "${monitor.data.temperature}" : "N/A",
            unit: 'Celcius',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.av_timer,
            title: 'Tekanan',
            data: (monitor.data != null)
                ? "${double.parse(monitor.data.pressure).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Psi',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus R',
            data: (monitor.data != null)
                ? "${double.parse(monitor.data.arusR).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus S',
            data: (monitor.data != null)
                ? "${double.parse(monitor.data.arusS).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus T',
            data: (monitor.data != null)
                ? "${double.parse(monitor.data.arusT).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus AC',
            data: (monitor.data != null)
                ? "${double.parse(monitor.data.arusAc).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan RS',
            data: (monitor.data != null) ? "${monitor.data.teganganRs}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan RT',
            data: (monitor.data != null) ? "${monitor.data.teganganRt}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan ST',
            data: (monitor.data != null) ? "${monitor.data.teganganSt}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan RN',
            data: (monitor.data != null) ? "${monitor.data.teganganRn}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan SN',
            data: (monitor.data != null) ? "${monitor.data.teganganSn}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan TN',
            data: (monitor.data != null) ? "${monitor.data.teganganTn}" : "N/A",
            unit: 'Volt',
          ),
        ],
      ),
    );
  }
}
