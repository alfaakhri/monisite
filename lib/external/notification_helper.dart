import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../presentation/screen/nav_bottom_main.dart';

class PayloadNotification {
  PayloadNotification({
    required this.issueId,
    required this.type,
    required this.title,
    required this.status,
    required this.desc,
  });

  final String issueId;
  final String type;
  final String title;
  final String status;
  final String desc;

  PayloadNotification copyWith({
    String? issueId,
    String? type,
    String? title,
    String? status,
    String? desc,
  }) {
    return PayloadNotification(
      issueId: issueId ?? this.issueId,
      type: type ?? this.type,
      title: title ?? this.title,
      status: status ?? this.status,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'issueId': issueId,
      'type': type,
      'title': title,
      'status': status,
      'desc': desc,
    };
  }

  factory PayloadNotification.fromMap(Map<String, dynamic> map) {
    return PayloadNotification(
      issueId: map['issueId'] as String,
      type: map['type'] as String,
      title: map['title'] as String,
      status: map['status'] as String,
      desc: map['desc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PayloadNotification.fromJson(String source) =>
      PayloadNotification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PayloadNotification(issueId: $issueId, type: $type, title: $title, status: $status, desc: $desc)';
  }

  @override
  bool operator ==(covariant PayloadNotification other) {
    if (identical(this, other)) return true;

    return other.issueId == issueId &&
        other.type == type &&
        other.title == title &&
        other.status == status &&
        other.desc == desc;
  }

  @override
  int get hashCode {
    return issueId.hashCode ^
        type.hashCode ^
        title.hashCode ^
        status.hashCode ^
        desc.hashCode;
  }
}

class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._();

  factory NotificationHelper() {
    return _instance;
  }

  NotificationHelper._();

  bool isFlutterLocalNotificationsInitialized = false;

  late AndroidNotificationChannel androidNotificationChannel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: false,
          );
    } else if (Platform.isAndroid) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
  }

  void onSelectedNotification(
    NotificationResponse notificationResponse, {
    void Function(NotificationResponse notificationResponse)?
        otherSelectedNotification,
  }) {
    otherSelectedNotification?.call(notificationResponse);
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    androidNotificationChannel = const AndroidNotificationChannel(
      'alterstaff_channel',
      'Alterrstaff',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await _requestPermissions();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        onSelectedNotification(
          details,
          otherSelectedNotification: (notificationResponse) async {
            var payload = jsonDecode(notificationResponse.payload ?? "");
            print("NOTIFICATION : $payload");
            await Get.to(NavBottomMain(indexPage: 2));
          },
        );
      },
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  void showNotificationFromFCM(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        androidNotificationChannel.id,
        androidNotificationChannel.name,
        channelDescription: androidNotificationChannel.description,
      );
      const darwinPlatformChannelSpecifics = DarwinNotificationDetails(
        presentSound: true,
        presentAlert: true,
        presentBadge: true,
      );

      final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinPlatformChannelSpecifics,
      );

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: PayloadNotification(
          issueId: message.data['issue_id'],
          title: message.data['title'],
          desc: message.data['desc'],
          status: message.data['status'],
          type: message.data['type'],
        ).toJson(),
      );
    }
  }
}
