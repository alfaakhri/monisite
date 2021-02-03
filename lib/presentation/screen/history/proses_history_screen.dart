import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/notification/notification_model.dart';
import 'package:flutter_monisite/data/models/site/site.dart';
import 'package:flutter_monisite/data/repository/api_service.dart';
import 'package:flutter_monisite/domain/bloc/notif_bloc/notif_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:flutter_monisite/presentation/widgets/loading_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProcessHistoryScreen extends StatefulWidget {
  @override
  _ProcessHistoryScreenState createState() => _ProcessHistoryScreenState();
}

class _ProcessHistoryScreenState extends State<ProcessHistoryScreen> {
  NotifBloc notifBloc;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    notifBloc = BlocProvider.of<NotifBloc>(context);
    notifBloc.add(GetListNotif());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotifBloc, NotifState>(
      listener: (context, state) {
        if (state is PostHistoryProcessLoading) {
          LoadingWidget.showLoadingDialog(context, _keyLoader);
        } else if (state is PostHistoryProcessFailed) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          Fluttertoast.showToast(msg: state.message);
        } else if (state is PostHistoryProcessSuccess) {
          Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
          if (state.status == 2) {
            Fluttertoast.showToast(msg: "Berhasil");
          } else {
            Fluttertoast.showToast(msg: "Batal");
          }

          notifBloc.add(GetListNotif());
        }
      },
      builder: (context, state) {
        if (state is GetListNotifFailed) {
          return ErrorHandlingWidget(
              icon: "images/laptop.png",
              title: state.message,
              subTitle: "Silahkan kembali dalam beberapa saat lagi.");
        } else if (state is GetListNotifSuccess) {
          return _contentListHistory(state.notificationModel);
        } else if (state is GetListNotifLoading) {
          return _skeletonLoading();
        } else if (state is GetListNotifEmpty) {
          return ErrorHandlingWidget(
              icon: "images/laptop.png",
              title: "Data site kosong",
              subTitle: "Silahkan kembali dalam beberapa saat lagi.");
        } else if (state is PostHistoryProcessFailed) {
          return ErrorHandlingWidget(
              icon: "images/laptop.png",
              title: state.message,
              subTitle: "Silahkan kembali dalam beberapa saat lagi.");
        } else if (state is PostHistoryProcessLoading) {
          return _contentListHistory(notifBloc.notifModel);
        }
        return _skeletonLoading();
      },
    );
  }

  Widget _skeletonLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _contentListHistory(NotificationModel notif) {
    return Scaffold(
      backgroundColor: ColorHelpers.colorWhite,
      body: ListView(
        children: notif.data.map((element) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: (element.status == 1)
                    ? Card(
                        color: ColorHelpers.colorGreyField,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  element.siteName,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              UIHelper.verticalSpaceSmall,
                              Text(
                                "Tenant OM: " + element.tenantOm,
                                style: TextStyle(fontSize: 12),
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Container(
                                  child: Text(
                                element.address,
                                maxLines: 3,
                                style: TextStyle(fontSize: 12),
                              )),
                              UIHelper.verticalSpaceSmall,
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Yang perlu ditinjau: ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Waktu diterima: ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    element.acceptTime,
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Text(
                                'Pekerja: ' + 'Tim On Site',
                                style: TextStyle(fontSize: 12),
                              ),
                              UIHelper.verticalSpaceSmall,
                              Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: RaisedButton(
                                      onPressed: () {
                                        notifBloc.add(
                                            PostHistoryProcess(element.id, 3));
                                      },
                                      color: ColorHelpers.colorRed,
                                      child: Text(
                                        "Batal",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall,
                                  Expanded(
                                      flex: 5,
                                      child: RaisedButton(
                                        onPressed: () {
                                          notifBloc.add(PostHistoryProcess(
                                              element.id, 2));
                                        },
                                        color: ColorHelpers.colorGreen,
                                        child: Text(
                                          "Selesai",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ),
              UIHelper.verticalSpaceVerySmall,
            ],
          );
        }).toList(),
      ),
    );
  }
}
