import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/presentation/screen/splash/splash_screen.dart';
import 'package:get/get.dart';

import 'login/login_screen.dart';
import 'nav_bottom_main.dart';

// Future _showNotificationWithDefaultSound(String title, String message) async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'channel_id', 'channel_name', 'channel_description',
//       importance: Importance.max, priority: Priority.high);
//   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     '$title',
//     '$message',
//     platformChannelSpecifics,
//     payload: 'Default_Sound',
//   );
// }

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//   if (message['data'] != null) {
//     final data = message['data'];

//     // final title = data['key'];
//     // final notif = jsonDecode(data);
//     final title = data['title'];
//     final body = data['body'];

//     await _showNotificationWithDefaultSound(
//         title, body);

//     // print("Description: " + description);
//     // print("Body: " + body.toString());
//     // print("DataValue: " + data['value'].toString());
//   }
//   return Future<void>.value();
// }

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late AuthBloc authBloc;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(StartApp());

    // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    // var initializationSettingsAndroid =
    //     new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var initializationSettingsIOS = new IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // var initializationSettings = new InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   iOS: initializationSettingsIOS,
    // );
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: onSelectNotification);

    // print('Configuring Firebase Messsaging');
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> _message) async {
    // final data = _message['data'];
    // final body = jsonDecode(data['value']);
    // final transaksiID = body['TransaksiID'];
    // final roleID = body['FromRole'];
    // final isNote = body['IsNote'];

    // print('TransaksiID: $transaksiID');P
    //   print("onMessage2: $_message");

    //   myBackgroundMessageHandler(_message);
    // },
    // onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
    // onLaunch: (Map<String, dynamic> message) async {
    // _firebaseMessaging.onTokenRefresh;

    //   print("onLaunch1: $message");
    //   _navigateToItemDetail(message, context);
    // },
    // onResume: (Map<String, dynamic> message) async {
    // _firebaseMessaging.onTokenRefresh;

    //       print("onResume1: $message");
    //       _navigateToItemDetail(message, context);
    //     },
    //   );
    }

    // void _navigateToItemDetail(
    //     Map<String, dynamic> message, BuildContext context) {
    //   print("navigateToItemDetail");

    //   Get.to(NavBottomMain(
    //     indexPage: 2,
    //   ));
    // }

    Future onDidReceiveLocalNotification(
        int id, String title, String body, String payload) async {
      // display a dialog with the notification details, tap ok to go to another page
      showDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: new Text('Ok'),
              onPressed: () async {
                print("Local notif cek");
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new NavBottomMain(
                      indexPage: 2,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      );
    }

    Future onSelectNotification(String payload) async {
      debugPrint('notification payload: ' + payload);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavBottomMain(
                    indexPage: 2,
                  )));
    }

    @override
    Widget build(BuildContext context) {
      return BlocConsumer(
        bloc: authBloc,
        listener: (context, state) {
          if (state is GetAuthSuccess) {
            Get.offAll(NavBottomMain(
              indexPage: 0,
            ));
          } else if (state is GetAuthFailed) {
            Get.offAll(LoginScreen());
          } else if (state is GetAuthMustLogin) {
            Get.offAll(LoginScreen());
          }
        },
        builder: (context, state) {
          if (state is GetAuthLoading) {
            return SplashScreen();
          }
          return Container(
            color: ColorHelpers.colorWhite,
          );
        },
      );
    }
}
