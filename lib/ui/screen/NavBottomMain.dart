import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './account/AccountScreen.dart' as account;
import './history/HistoryScreen.dart' as history;
import './home/HomeScreen.dart' as home;
import './report/ReportScreen.dart' as report;
import './notification/NotificationScreen.dart' as notification;

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("_backgroundMessageHandler data: $data");
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print("_backgroundMessageHandler notification: $notification");
  }

  // Or do other work.
}

class NavBottomMain extends StatefulWidget {
  static const String id = "nav_bottom_main";

  @override
  _NavBottomMainState createState() => _NavBottomMainState();
}

class _NavBottomMainState extends State<NavBottomMain>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  TabController controller;

  bool _newNotification = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 5);
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      print('Configuring Firebase Messsaging');
      // _firebaseMessaging.configure(
      //   onMessage: (Map<String, dynamic> message) async {
      //     print("onMessage: $message");
      //     setState(() {
      //       _newNotification = true;
      //     });
      //   },
      //   onBackgroundMessage: myBackgroundMessageHandler,
      //   onLaunch: (Map<String, dynamic> message) async {
      //     _firebaseMessaging.onTokenRefresh;

      //     print("onLaunch: $message");
      //     _navigateToItemDetail(message);
      //   },
      //   onResume: (Map<String, dynamic> message) async {
      //     _firebaseMessaging.onTokenRefresh;

      //     print("onResume: $message");
      //     _navigateToItemDetail(message);
      //   },
      // );
    });

    // //Getting the token from FCM
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //   print("ini token " + token);
    // });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //buat body untuk tab viewnya
      body: SafeArea(
        child: new TabBarView(
          //controller untuk tab bar
          controller: controller,
          children: <Widget>[
            //kemudian panggil halaman sesuai tab yang sudah dibuat
            new home.HomeScreen(),
            new report.ReportScreen(),
            new history.HistoryScreen(),
            new notification.NotificationScreen(),
            new account.AccountScreen(),
          ],
        ),
      ),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: TabBar(
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          controller: controller,
          onTap: (index) {
            _onItemTapped(index);
          },
          tabs: <Widget>[
            new Tab(
              child: Text(
                "Home",
                style: TextStyle(fontSize: 12),
              ),
              icon: new Icon(
                Icons.home,
              ),
            ),
            new Tab(
              child: Text(
                "Report",
                style: TextStyle(fontSize: 12),
              ),
              icon: new Icon(Icons.report),
            ),
            new Tab(
              child: Text(
                "History",
                style: TextStyle(fontSize: 12),
              ),
              icon: new Icon(Icons.history),
            ),
            _newNotification
                ? Stack(
                    children: <Widget>[
                      Tab(
                        child: Text(
                          "Notification",
                          style: TextStyle(fontSize: 12),
                        ),
                        icon: new Icon(Icons.notifications),
                      ),
                      Positioned(
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
                      )
                    ],
                  )
                : Tab(
                    child: Text(
                      "Notification",
                      style: TextStyle(fontSize: 12),
                    ),
                    icon: new Icon(Icons.notifications),
                  ),
            new Tab(
              child: Text(
                "Account",
                style: TextStyle(fontSize: 12),
              ),
              icon: new Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }

  //PRIVATE METHOD TO HANDLE NAVIGATION TO SPECIFIC PAGE
  void _navigateToItemDetail(Map<String, dynamic> message) {
    final MessageBean item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  //PRIVATE METHOD TO HANDLE TAPPED EVENT ON THE BOTTOM BAR ITEM
  void _onItemTapped(int index) {
    setState(() {
      print(index);
      if (index == 3) {
        _newNotification = false;
      }
    });
  }
}

final Map<String, MessageBean> _items = <String, MessageBean>{};
MessageBean _itemForMessage(Map<String, dynamic> message) {
  //If the message['data'] is non-null, we will return its value, else return map message object
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final MessageBean item = _items.putIfAbsent(
      itemId, () => MessageBean(itemId: itemId))
    ..status = data['status'];
  return item;
}

//Model class to represent the message return by FCM
class MessageBean {
  MessageBean({this.itemId});
  final String itemId;

  StreamController<MessageBean> _controller =
      StreamController<MessageBean>.broadcast();
  Stream<MessageBean> get onChanged => _controller.stream;

  String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    return routes.putIfAbsent(
      routeName,
      () => MaterialPageRoute<void>(
        settings: RouteSettings(name: routeName),
        builder: (BuildContext context) => notification.NotificationScreen(
          itemId: itemId,
          items: _items,
        ),
      ),
    );
  }
}
