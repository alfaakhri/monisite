import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_monisite/core/routes/router.dart';
import 'package:flutter_monisite/core/routes/router.gr.dart';
import 'package:flutter_monisite/ui/screen/NavBottomMain.dart';

class NotificationScreen extends StatefulWidget {
  final String itemId;
  final Map<String, MessageBean> items;

  static const String id = "notification_screen";

  const NotificationScreen({Key key, this.itemId, this.items})
      : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  MessageBean _item;
  StreamSubscription<MessageBean> _subscription;

  @override
  void initState() {
    super.initState();
    // _item = widget.items[widget.itemId];
    // _subscription = _item.onChanged.listen((MessageBean item) {
    //   if (!mounted) {
    //     _subscription.cancel();
    //   } else {
    //     setState(() {
    //       _item = item;
    //     });
    //   }
    // });
  }

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
                        Navigator.pushNamed(context, Router.detailNotificationScreen);
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
                              child: Text("13/03/20", style: TextStyle(fontSize: 10),),
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
