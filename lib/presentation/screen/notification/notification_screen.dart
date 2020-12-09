import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/data/models/notification/notification_model.dart';
import 'package:flutter_monisite/domain/bloc/notif_bloc/notif_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:flutter_monisite/presentation/screen/notification/detail_notification_screen.dart';
import 'package:flutter_monisite/presentation/widgets/error_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotifBloc notifBloc;
  String date;

  @override
  void initState() {
    super.initState();
    notifBloc = BlocProvider.of<NotifBloc>(context);
    notifBloc.add(GetListNotif());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pemberitahuan"),
      ),
      body: BlocBuilder<NotifBloc, NotifState>(
        builder: (context, state) {
          if (state is GetListNotifFailed) {
            return ErrorHandlingWidget(
                icon: "images/laptop.png",
                title: state.message,
                subTitle: "Silahkan kembali dalam beberapa saat lagi.");
          } else if (state is GetListNotifSuccess) {
            return _contentListNotif(state.notificationModel);
          } else if (state is GetListNotifLoading) {
            return _skeletonLoading();
          } else if (state is GetListNotifEmpty) {
            return ErrorHandlingWidget(
                icon: "images/laptop.png",
                title: "Data site kosong",
                subTitle: "Silahkan kembali dalam beberapa saat lagi.");
          }
          return _skeletonLoading();
        },
      ),
    );
  }

  Widget _skeletonLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Container _contentListNotif(NotificationModel notif) {
    return Container(
      child: ListView(
        children: notif.data.map((element) {
          DataNotification notify = element;
          var dateOnly = notify.createdAt;
          bool checkDate;
          if (date == null) {
            date = dateOnly;
            checkDate = false;
            print("dateNull : $date");
          } else {
            if (date.contains(dateOnly)) {
              checkDate = true;
              print("dateTrue : $date");
            } else {
              checkDate = false;
              date = dateOnly;
              print("dateFalse : $date");
            }
          }
          return GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (checkDate == true)
                    ? Container()
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        child: Text(
                          DateFormat("d/MM/yyyy")
                              .format(DateTime.parse(date).toLocal()),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        decoration: BoxDecoration(
                          color: ColorHelpers.colorBorder,
                        ),
                      ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(element.title,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            UIHelper.verticalSpaceVerySmall,
                            Text(element.body,
                                maxLines: 2,
                                style: TextStyle(color: Colors.black))
                          ],
                        ),
                        Text(
                            DateFormat("HH:mm").format(
                                DateTime.parse(notify.createdAt).toLocal()),
                            style:
                                TextStyle(fontSize: 11, color: Colors.black)),
                      ],
                    )),
                Divider(
                  height: 1,
                  color: ColorHelpers.colorGrey,
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
