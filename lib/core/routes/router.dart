import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_monisite/ui/screen/NavBottomMain.dart';
import 'package:flutter_monisite/ui/screen/account/AccountScreen.dart';
import 'package:flutter_monisite/ui/screen/history/HistoryScreen.dart';
import 'package:flutter_monisite/ui/screen/home/DetailHomeScreen.dart';
import 'package:flutter_monisite/ui/screen/home/HomeScreen.dart';
import 'package:flutter_monisite/ui/screen/login/LoginScreen.dart';
import 'package:flutter_monisite/ui/screen/login/SignupPage.dart';
import 'package:flutter_monisite/ui/screen/notification/DetailNotificationScreen.dart';
import 'package:flutter_monisite/ui/screen/notification/NotificationScreen.dart';
import 'package:flutter_monisite/ui/screen/report/ReportScreen.dart';
import 'package:flutter_monisite/ui/screen/root_page.dart';

//flutter pub run build_runner watch --delete-conflicting-outputs

@autoRouter
class $Router {
  @initial
  RootPage initialPage;
  NavBottomMain navBottomMain;
  AccountScreen accountScreen;
  HistoryScreen historyScreen;
  HomeScreen homeScreen;
  // DetailHomeScreen detailHomeScreen;
  LoginScreen loginScreen;
  SignUpPage signUpPage;
  NotificationScreen notificationScreen;
  DetailNotificationScreen detailNotificationScreen;
  ReportScreen reportScreen;
}
