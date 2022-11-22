import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/notification/notification_model.dart';
import 'package:flutter_monisite/domain/bloc/notif_bloc/notif_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';

class CompleteHistoryScreen extends StatefulWidget {
  @override
  _CompleteHistoryScreenState createState() => _CompleteHistoryScreenState();
}

class _CompleteHistoryScreenState extends State<CompleteHistoryScreen> {
  late NotifBloc notifBloc;

  @override
  void initState() {
    super.initState();
    notifBloc = BlocProvider.of<NotifBloc>(context);
    notifBloc.add(GetListNotif());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotifBloc, NotifState>(
      listener: (context, state) {},
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
      backgroundColor: Colors.white,
      body: ListView(
        children: notif.data!.map((element) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: (element.status == 2 || element.status == 3)
                    ? Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  element.siteName ?? "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              UIHelper.verticalSpaceSmall,
                              Text(
                                "Tenant OM: ${element.tenantOm ?? ""}",
                                style: TextStyle(fontSize: 12),
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Container(
                                  child: Text(
                                element.address ?? "",
                                maxLines: 3,
                                style: TextStyle(fontSize: 12),
                              )),
                              UIHelper.verticalSpaceSmall,
                              Row(
                                children: <Widget>[
                                  Text(
                                    (element.status == 2)
                                        ? 'Telah ditinjau: '
                                        : "Batal ditinjau: ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    element.title ?? "",
                                    style: TextStyle(
                                        color: (element.status == 2)
                                            ? ColorHelpers.colorGreen
                                            : Colors.red,
                                        fontSize: 12),
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
                                    element.acceptTime ?? '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Row(
                                children: <Widget>[
                                  Text(
                                    (element.status == 2)
                                        ? 'Waktu diselesaikan: '
                                        : "Waktu dibatalkan: ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    element.fixingTime ?? "",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Text(
                                'Pekerja: ' + 'Tim On Site',
                                style: TextStyle(fontSize: 12),
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
