// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:flutter_monisite/ui/screen/root_page.dart';
import 'package:flutter_monisite/ui/screen/NavBottomMain.dart';
import 'package:flutter_monisite/ui/screen/account/AccountScreen.dart';
import 'package:flutter_monisite/ui/screen/history/HistoryScreen.dart';
import 'package:flutter_monisite/ui/screen/home/HomeScreen.dart';
import 'package:flutter_monisite/ui/screen/login/LoginScreen.dart';
import 'package:flutter_monisite/ui/screen/login/SignupPage.dart';
import 'package:flutter_monisite/ui/screen/notification/NotificationScreen.dart';
import 'package:flutter_monisite/ui/screen/notification/DetailNotificationScreen.dart';
import 'package:flutter_monisite/ui/screen/report/ReportScreen.dart';

class Router {
  static const initialPage = '/';
  static const navBottomMain = '/nav-bottom-main';
  static const accountScreen = '/account-screen';
  static const historyScreen = '/history-screen';
  static const homeScreen = '/home-screen';
  static const loginScreen = '/login-screen';
  static const signUpPage = '/sign-up-page';
  static const notificationScreen = '/notification-screen';
  static const detailNotificationScreen = '/detail-notification-screen';
  static const reportScreen = '/report-screen';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.initialPage:
        return MaterialPageRoute(
          builder: (_) => RootPage(),
          settings: settings,
        );
      case Router.navBottomMain:
        return MaterialPageRoute(
          builder: (_) => NavBottomMain(),
          settings: settings,
        );
      case Router.accountScreen:
        return MaterialPageRoute(
          builder: (_) => AccountScreen(),
          settings: settings,
        );
      case Router.historyScreen:
        return MaterialPageRoute(
          builder: (_) => HistoryScreen(),
          settings: settings,
        );
      case Router.homeScreen:
        if (hasInvalidArgs<HomeScreenArguments>(args)) {
          return misTypedArgsRoute<HomeScreenArguments>(args);
        }
        final typedArgs = args as HomeScreenArguments ?? HomeScreenArguments();
        return MaterialPageRoute(
          builder: (_) =>
              HomeScreen(key: typedArgs.key, userId: typedArgs.userId),
          settings: settings,
        );
      case Router.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case Router.signUpPage:
        return MaterialPageRoute(
          builder: (_) => SignUpPage(),
          settings: settings,
        );
      case Router.notificationScreen:
        if (hasInvalidArgs<NotificationScreenArguments>(args)) {
          return misTypedArgsRoute<NotificationScreenArguments>(args);
        }
        final typedArgs = args as NotificationScreenArguments ??
            NotificationScreenArguments();
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(
              key: typedArgs.key,
              itemId: typedArgs.itemId,
              items: typedArgs.items),
          settings: settings,
        );
      case Router.detailNotificationScreen:
        return MaterialPageRoute(
          builder: (_) => DetailNotificationScreen(),
          settings: settings,
        );
      case Router.reportScreen:
        return MaterialPageRoute(
          builder: (_) => ReportScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//HomeScreen arguments holder class
class HomeScreenArguments {
  final Key key;
  final String userId;
  HomeScreenArguments({this.key, this.userId});
}

//NotificationScreen arguments holder class
class NotificationScreenArguments {
  final Key key;
  final String itemId;
  final Map<String, MessageBean> items;
  NotificationScreenArguments({this.key, this.itemId, this.items});
}
