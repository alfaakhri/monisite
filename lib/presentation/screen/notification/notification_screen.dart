import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_monisite/presentation/screen/notification/detail_notification_screen.dart';
import 'package:get/get.dart';

import '../nav_bottom_main.dart';

class NotificationScreen extends StatefulWidget {
  final String itemId;

  static const String id = "notification_screen";

  const NotificationScreen({Key key, this.itemId}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(DetailNotificationScreen());
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "HIGH TEMPERATURE",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Tower STO Sunter")
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Text(
                                "13/03/20",
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Divider(
                  height: 1,
                  color: Colors.grey,
                )
              ],
            );
          },
          itemCount: 5,
        ),
      ),
    );
  }
}
