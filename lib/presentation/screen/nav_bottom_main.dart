import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'account/account_screen.dart' as account;
import 'history/history_screen.dart' as history;
import 'home/home_screen.dart' as home;
import 'report/report_screen.dart' as report;
import 'notification/notification_screen.dart' as notification;

class NavBottomMain extends StatefulWidget {
  static const String id = "nav_bottom_main";

  @override
  _NavBottomMainState createState() => _NavBottomMainState();
}

class _NavBottomMainState extends State<NavBottomMain>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar

  bool _newNotification = false;
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  static List<Widget> _widgetOptions = <Widget>[
    new home.HomeScreen(),
    new history.HistoryScreen(),
    new notification.NotificationScreen(),
    new account.AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorHelpers.colorWhite,
      body: Center(child: _widgetOptions.elementAt(_page)),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        height: 60,
        backgroundColor: Colors.transparent,
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: ColorHelpers.colorWhite),
          Icon(Icons.history, size: 30, color: ColorHelpers.colorWhite),
          (_newNotification)
              ? Stack(
                  children: [
                    Icon(Icons.notifications,
                        size: 30, color: ColorHelpers.colorWhite),
                    _iconRedNotification(),
                  ],
                )
              : Icon(Icons.notifications,
                  size: 30, color: ColorHelpers.colorWhite),
          Icon(Icons.account_circle, size: 30, color: ColorHelpers.colorWhite),
        ],
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }

  //PRIVATE METHOD TO HANDLE TAPPED EVENT ON THE BOTTOM BAR ITEM
  void _onItemTapped(int index) {
    setState(() {
      print(index);
      if (index == 3) {
        _newNotification = false;
      }
      _page = index;
    });
  }

  Widget _iconRedNotification() {
    return Positioned(
      right: 10,
      top: 10,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        constraints: BoxConstraints(
          minWidth: 13,
          minHeight: 13,
        ),
        child: Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
