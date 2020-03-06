// import 'package:flutter/material.dart';
// import 'package:flutter_monisite/core/models/Monitor.dart';
// import 'package:flutter_monisite/core/models/Site.dart';
// import 'package:flutter_monisite/core/models/SiteById.dart';
// import 'package:flutter_monisite/core/provider/MonitorProvider.dart';
// import 'package:flutter_monisite/core/provider/SiteProvider.dart';
// import 'package:flutter_monisite/core/service/ApiService.dart';
// import 'package:flutter_monisite/ui/screen/home/MapScreen.dart';
// import 'package:flutter_monisite/ui/shared/ui_helpers.dart';
// import 'package:flutter_monisite/ui/widgets/container_sensor.dart';
// import 'package:provider/provider.dart';

// class DetailHomeScreen extends StatefulWidget {
//   static const String route = "detail_home_screen";

//   final String id;

//   const DetailHomeScreen({Key key, this.id}) : super(key: key);

//   @override
//   _DetailHomeScreenState createState() => _DetailHomeScreenState(this.id);
// }

// class _DetailHomeScreenState extends State<DetailHomeScreen> {
//   // RefreshController _refreshController =
//   //       RefreshController(initialRefresh: false);
//     ApiService apiService = ApiService();
//     Future<List<Site>> site;
//     final String id;
  
//     _DetailHomeScreenState(this.id);
  
//     @override
//     void didChangeDependencies() {
//       super.didChangeDependencies();
//       Future.delayed(Duration.zero, () {
//         Provider.of<SiteProvider>(context, listen: false).doFetchSiteById(id);
//         Provider.of<MonitorProvider>(context, listen: false).doFetchMonitor(id);
//       });
//     }
  
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text("Control Panel"),
//         ),
//         body: Consumer(
//           builder: (context, SiteProvider site, _) {
//             switch (site.state) {
//               case SiteState.loading:
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               case SiteState.loaded:
//                 return _buildDetailHomeScreen(site.siteById);
//               case SiteState.unloaded:
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       InkWell(
//                         child: Icon(
//                           Icons.refresh,
//                           size: 40,
//                           color: Colors.blue,
//                         ),
//                         onTap: () {
//                           site.doFetchSiteList();
//                         },
//                       ),
//                       UIHelper.verticalSpaceSmall,
//                       Text(site.failure.message)
//                     ],
//                   ),
//                 );
  
//               default:
//                 Center(
//                   child: CircularProgressIndicator(),
//                 );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       );
//     }
  
//     Container _buildDetailHomeScreen(List<SiteById> site) {
//       return Container(
//         padding: EdgeInsets.all(15.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Container(
//                 child: Text(
//                   site.single.sitename,
//                   style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Row(
//                 children: <Widget>[
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         child: Text("Site ID: ${site.single.siteid}"),
//                       ),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Container(
//                         child: Text("Tenant OM: ${site.single.tenantom}"),
//                       ),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Container(width: 250, child: Text(site.single.address)),
//                     ],
//                   ),
//                   SizedBox(
//                     width: 20.0,
//                   ),
//                   InkWell(
//                     onTap: () {
//                       var lat = site.single.latitude.replaceAll(',', '.');
//                       var long = site.single.longitude.replaceAll(',', '.');
  
//                       var route = new MaterialPageRoute(
//                         builder: (BuildContext context) => MapScreen(
//                           latitude: "$lat",
//                           longitude: "$long",
//                           sitename: "${site.single.sitename}",
//                         ),
//                       );
//                       Navigator.of(context).push(route);
//                     },
//                     child: Icon(
//                       Icons.map,
//                       size: 36,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Consumer(
//                 builder: (context, MonitorProvider monitor, _) {
//                   switch (monitor.state) {
//                     case MonitorState.loading:
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     case MonitorState.loaded:
//                       return columnDataUnit(monitor.monitor);
//                     case MonitorState.unloaded:
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             InkWell(
//                               child: Icon(
//                                 Icons.refresh,
//                                 size: 40,
//                                 color: Colors.blue,
//                               ),
//                               onTap: () {
//                                 monitor.doFetchMonitor(id);
//                               },
//                             ),
//                             UIHelper.verticalSpaceSmall,
//                             Text(monitor.failure)
//                           ],
//                         ),
//                       );
  
//                     default:
//                       Center(
//                         child: CircularProgressIndicator(),
//                       );
//                   }
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     }
  
//     Column columnDataUnit(List<Monitor> monitor) {
//       print(monitor.single.curr1.split(".").first);
//       return Column(
//         children: <Widget>[
//           ContainerSensor(
//             iconData: Icons.ac_unit,
//             title: 'Suhu',
//             data: "${monitor.single.temperature}",
//             unit: 'Celcius',
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           ContainerSensor(
//             iconData: Icons.av_timer,
//             title: 'Tekanan',
//             data: "${monitor.single.pressure}",
//             unit: 'Psi',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.lightbulb_outline,
//             title: 'Arus 1',
//             data: "${monitor.single.curr1.split(".").first}",
//             unit: 'A',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.lightbulb_outline,
//             title: 'Arus 2',
//             data: "${(double.parse(monitor.single.curr2)).toStringAsFixed(2)}",
//             unit: 'A',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.lightbulb_outline,
//             title: 'Arus 3',
//             data: "${(double.parse(monitor.single.curr3)).toStringAsFixed(2)}",
//             unit: 'A',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.lightbulb_outline,
//             title: 'Arus AC',
//             data: "${double.parse(monitor.single.currAirCon).toStringAsFixed(2)}",
//             unit: 'A',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.flash_on,
//             title: 'Tegangan 1',
//             data: "${double.parse(monitor.single.volt1).toStringAsFixed(2)}",
//             unit: 'Volt',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.flash_on,
//             title: 'Tegangan 2',
//             data: "${double.parse(monitor.single.volt2).toStringAsFixed(2)}",
//             unit: 'Volt',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.flash_on,
//             title: 'Tegangan 3',
//             data: "${double.parse(monitor.single.volt3).toStringAsFixed(2)}",
//             unit: 'Volt',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.flash_on,
//             title: 'Tegangan 4',
//             data: "${double.parse(monitor.single.volt4).toStringAsFixed(2)}",
//             unit: 'Volt',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.flash_on,
//             title: 'Tegangan 5',
//             data: "${double.parse(monitor.single.volt5).toStringAsFixed(2)}",
//             unit: 'Volt',
//           ),
//           SizedBox(
//             height: 10.0,
//           ),
//           ContainerSensor(
//             iconData: Icons.flash_on,
//             title: 'Tegangan 6',
//             data: "${double.parse(monitor.single.volt6).toStringAsFixed(2)}",
//             unit: 'Volt',
//           ),
//         ],
//       );
//     }
//   }