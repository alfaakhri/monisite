import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/notification/notification_model.dart';
import 'package:flutter_monisite/domain/bloc/notif_bloc/notif_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/screen/home/detail_site_monitor_screen.dart';
import 'package:flutter_monisite/presentation/widgets/loading_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DetailNotificationScreen extends StatefulWidget {
  final DataNotification dataNotification;

  const DetailNotificationScreen({Key key, this.dataNotification})
      : super(key: key);
  @override
  _DetailNotificationScreenState createState() =>
      _DetailNotificationScreenState();
}

class _DetailNotificationScreenState extends State<DetailNotificationScreen> {
  NotifBloc notifBloc;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    notifBloc = BlocProvider.of<NotifBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        notifBloc.add(GetListNotif());
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: ColorHelpers.colorWhite,
          appBar: AppBar(
            title: Text("Detail"),
            leading: IconButton(
              onPressed: () {
                notifBloc.add(GetListNotif());
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.dataNotification.status == 0) {
                        notifBloc
                            .add(PostAcceptNotif(widget.dataNotification.id));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                          color: (widget.dataNotification.status == 0)
                              ? Colors.blue
                              : ColorHelpers.colorDefault,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        (widget.dataNotification.status == 0)
                            ? "TINJAU KE LOKASI"
                            : "SEDANG / SELESAI DI TINJAU",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ))),
          body: BlocListener<NotifBloc, NotifState>(
            listener: (context, state) {
              if (state is PostAcceptNotifLoading) {
                LoadingWidget.showLoadingDialog(context, _keyLoader);
              } else if (state is PostAcceptNotifSuccess) {
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
                Fluttertoast.showToast(msg: "Berhasil ditinjau");
                notifBloc.add(GetListNotif());
                Get.back();
              } else if (state is PostAcceptNotifFailed) {
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
                Fluttertoast.showToast(msg: state.message);
              }
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue.shade50,
                        child: Image.asset(
                          "images/tower.png",
                          scale: 6.5,
                        )),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("Data Tower",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      UIHelper.verticalSpaceVerySmall,
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.dataNotification.siteName,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            UIHelper.verticalSpaceSmall,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.text_snippet,
                                    color: Colors.blue, size: 20),
                                UIHelper.horizontalSpaceVerySmall,
                                Container(
                                    child: Text(
                                  "Kode: ${widget.dataNotification.code}",
                                )),
                              ],
                            ),
                            UIHelper.verticalSpaceVerySmall,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.cloud, color: Colors.blue, size: 20),
                                UIHelper.horizontalSpaceVerySmall,
                                Container(
                                  child: Text(
                                    "Tenant OM: ${widget.dataNotification.tenantOm}",
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpaceVerySmall,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.place, color: Colors.blue, size: 20),
                                UIHelper.horizontalSpaceVerySmall,
                                Expanded(
                                  child: Container(
                                      child: Text(
                                    widget.dataNotification.address,
                                    maxLines: 3,
                                  )),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: RaisedButton(
                                    onPressed: () {
                                      Get.to(DetailSiteMonitorScreen(
                                        siteID: widget.dataNotification.siteId,
                                      ));
                                    },
                                    color: Colors.blue,
                                    child: Text("Detail",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                UIHelper.horizontalSpaceVerySmall,
                                Expanded(
                                  flex: 5,
                                  child: RaisedButton(
                                    onPressed: () async {
                                      final availableMaps =
                                          await MapLauncher.installedMaps;

                                      await availableMaps.first.showMarker(
                                        coords: Coords(
                                            double.parse(widget
                                                .dataNotification.latitude),
                                            double.parse(widget
                                                .dataNotification.longitude)),
                                        title: widget.dataNotification.siteName,
                                      );

                                      Navigator.pop(context);
                                    },
                                    color: ColorHelpers.colorGreen,
                                    child: Text("Buka Map",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                      UIHelper.verticalSpaceSmall,
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("Catatan",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      UIHelper.verticalSpaceVerySmall,
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(widget.dataNotification.body),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
