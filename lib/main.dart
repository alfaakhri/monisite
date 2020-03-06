import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_monisite/core/provider/AuthProvider.dart';
import 'package:flutter_monisite/core/provider/HistoryProvider.dart';
import 'package:flutter_monisite/core/provider/MonitorProvider.dart';
import 'package:flutter_monisite/core/provider/NotificationProvider.dart';
import 'package:flutter_monisite/core/provider/SiteProvider.dart';

import 'package:provider/provider.dart';

import 'core/routes/router.gr.dart';

void main() => runApp(MyApp());

Future _showNotificationWithDefaultSound(String title, String message) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', 'channel_name', 'channel_description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    '$title',
    '$message',
    platformChannelSpecifics,
    payload: 'Default_Sound',
  );
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message['data'] != null) {
    final data = message['data'];

    final title = data['title'];
    final body = data['message'];

    await _showNotificationWithDefaultSound(
        "Notification", "Lorem ipsum sir dolar amet");
    // var value = data['value'].toString().split(new RegExp(r'"\"*'));
    print(data['value']);
    // print(value);
  }
  return Future<void>.value();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider.instance()),
        ChangeNotifierProvider(
          create: (_) => SiteProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MonitorProvider(),
        ),
        ChangeNotifierProvider(create: (_) => NotificationProvider(),),
        ChangeNotifierProvider(create: (_) => HistoryProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Router.initialPage,
        onGenerateRoute: Router.onGenerateRoute,
        navigatorKey: Router.navigatorKey,
      ),
    );
  }
}
