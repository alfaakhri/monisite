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
import 'package:skeleton_text/skeleton_text.dart';

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
      backgroundColor: ColorHelpers.colorWhite,
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
    return SkeletonAnimation(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  color: ColorHelpers.colorGrey,
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }

  Container _contentListNotif(NotificationModel notif) {
    return Container(
      child: ListView(
        children: notif.data.map((element) {
          DataNotification notify = element;
          var dateOnly = notify.createdAt.split("T")[0];
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
            onTap: () {
              Get.to(DetailNotificationScreen(
                dataNotification: element,
              ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                (checkDate == true)
                    ? Container()
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 15, top: 5, bottom: 10),
                        child: Text(
                          DateFormat("d/MM/yyyy")
                              .format(DateTime.parse(date).toLocal()),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                          color: ColorHelpers.colorBackground,
                        ),
                      ),
                Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(element.title,
                                    style: TextStyle(
                                        color: (element.status == 0)
                                            ? Colors.black
                                            : ColorHelpers.colorGreyTextField,
                                        fontWeight: FontWeight.w700)),
                              ),
                              UIHelper.verticalSpaceVerySmall,
                              Text(element.body,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: (element.status == 0)
                                          ? Colors.black
                                          : ColorHelpers.colorGreyTextField))
                            ],
                          ),
                        ),
                        Text(
                            DateFormat("HH:mm").format(
                                DateTime.parse(notify.createdAt).toLocal()),
                            style: TextStyle(
                                fontSize: 11,
                                color: (element.status == 0)
                                    ? Colors.black
                                    : ColorHelpers.colorGreyTextField)),
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
