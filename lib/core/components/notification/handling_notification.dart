import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monisite/core/components/notification/item_message.dart';
import 'package:flutter_monisite/core/components/notification/message_bean.dart';
import 'package:flutter_monisite/core/provider/NotificationProvider.dart';
import 'package:flutter_monisite/main.dart';
import 'package:provider/provider.dart';

class HandlingNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  ItemMessage itemMessage = ItemMessage();

  void fcmConfigure(BuildContext context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        Provider.of<NotificationProvider>(context).setNotify(true);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message, context);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message, context);
      },
    );
  }

  //PRIVATE METHOD TO HANDLE NAVIGATION TO SPECIFIC PAGE
  void _navigateToItemDetail(Map<String, dynamic> message, BuildContext context) {
    final MessageBean item = itemMessage.itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }
}
