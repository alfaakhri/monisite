import 'package:flutter/material.dart';
import 'package:flutter_monisite/data/models/Monitor.dart';
import 'package:flutter_monisite/data/models/SiteById.dart';
import 'package:flutter_monisite/domain/provider/monitor_provider.dart';
import 'package:flutter_monisite/domain/provider/site_provider.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/widgets/container_sensor.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home/map_screen.dart';

class SamplePulRefresh extends StatefulWidget {
  final String id;

  const SamplePulRefresh({Key key, this.id}) : super(key: key);
  @override
  _SamplePulRefreshState createState() => _SamplePulRefreshState();
}

class _SamplePulRefreshState extends State<SamplePulRefresh> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero, () {
      Provider.of<SiteProvider>(context, listen: false)
          .doFetchSiteById(widget.id);
      Provider.of<MonitorProvider>(context, listen: false)
          .doFetchMonitor(widget.id);
    });
  }

  String status = "In Progress";

  Widget buildCtn() {
    return Consumer(
      builder: (context, SiteProvider site, _) {
        switch (site.state) {
          case SiteState.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case SiteState.loaded:
            return _buildDetailHomeScreen(site.siteById);
          case SiteState.unloaded:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Icon(
                      Icons.refresh,
                      size: 40,
                      color: ColorHelpers.colorBlue,
                    ),
                    onTap: () {
                      site.doFetchSiteList();
                    },
                  ),
                  UIHelper.verticalSpaceSmall,
                  Text(site.failure.message)
                ],
              ),
            );

          default:
            Center(
              child: CircularProgressIndicator(),
            );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: false,
        child: buildCtn(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        header: WaterDropMaterialHeader(),
        onRefresh: () async {
          //monitor fetch data from network
          await Future.delayed(Duration(milliseconds: 1000));

          Provider.of<SiteProvider>(context, listen: false)
              .doFetchSiteById(widget.id);
          Provider.of<MonitorProvider>(context, listen: false)
              .doFetchMonitor(widget.id);

          if (mounted) setState(() {});
          _refreshController.refreshCompleted();

          /*
          if(failed){
           _refreshController.refreshFailed();
          }
        */
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
    );
  }

  Container _buildDetailHomeScreen(List<SiteById> site) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Consumer<MonitorProvider>(
          builder: (context, monitor, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Text("Status: ${monitor.status}"),
                decoration: BoxDecoration(
                  color: (monitor.status == "Stabil")
                      ? Colors.green
                      : (monitor.status == "In Progress")
                          ? Colors.yellow
                          : (monitor.status == "Belum Terpasang")
                              ? Colors.grey
                              : Colors.red,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: (monitor.status == "Stabil")
                          ? Colors.green
                          : (monitor.status == "In Progress")
                              ? Colors.yellow
                              : (monitor.status == "Belum Terpasang")
                                  ? Colors.grey
                                  : Colors.red),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      site.single.sitename,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text("Site ID: ${site.single.siteid}"),
                          ),
                          UIHelper.verticalSpaceVerySmall,
                          Container(
                            child: Text("Tenant OM: ${site.single.tenantom}"),
                          ),
                          UIHelper.verticalSpaceVerySmall,
                          Container(
                              width: 250, child: Text(site.single.address)),
                        ],
                      ),
                      UIHelper.horizontalSpaceMedium,
                      InkWell(
                        onTap: () {
                          var lat = site.single.latitude.replaceAll(',', '.');
                          var long = site.single.longitude.replaceAll(',', '.');

                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => MapScreen(
                              latitude: "$lat",
                              longitude: "$long",
                              sitename: "${site.single.sitename}",
                            ),
                          );
                          Navigator.of(context).push(route);
                        },
                        child: Icon(
                          Icons.map,
                          size: 36,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceMedium,
                  columnDataUnit(monitor.monitor, monitor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget columnDataUnit(List<Monitor> monitor, MonitorProvider provider) {
    print(provider.failure.toString());
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          // (provider.failure != null)
          //     ? Text("Alat sensor belum terpasang !")
          //     : Text(''),
          ContainerSensor(
            iconData: Icons.ac_unit,
            title: 'Suhu',
            data: (provider.failure == null)
                ? "${monitor.single.temperature}"
                : "N/A",
            unit: 'Celcius',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.av_timer,
            title: 'Tekanan',
            data: (provider.failure == null)
                ? "${double.parse(monitor.single.pressure).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Psi',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus 1',
            data: (provider.failure == null)
                ? "${double.parse(monitor.single.curr1).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus 2',
            data: (provider.failure == null)
                ? "${double.parse(monitor.single.curr2).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus 3',
            data: (provider.failure == null)
                ? "${double.parse(monitor.single.curr3).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.lightbulb_outline,
            title: 'Arus AC',
            data: (provider.failure == null)
                ? "${double.parse(monitor.single.currAirCon).toStringAsFixed(2)}"
                : "N/A",
            unit: 'Ampere',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan 1',
            data:
                (provider.failure == null) ? "${monitor.single.volt1}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan 2',
            data:
                (provider.failure == null) ? "${monitor.single.volt2}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan 3',
            data:
                (provider.failure == null) ? "${monitor.single.volt3}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan 4',
            data:
                (provider.failure == null) ? "${monitor.single.volt4}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan 5',
            data:
                (provider.failure == null) ? "${monitor.single.volt5}" : "N/A",
            unit: 'Volt',
          ),
          UIHelper.verticalSpaceSmall,
          ContainerSensor(
            iconData: Icons.flash_on,
            title: 'Tegangan 6',
            data:
                (provider.failure == null) ? "${monitor.single.volt6}" : "N/A",
            unit: 'Volt',
          ),
        ],
      ),
    );
  }
}
