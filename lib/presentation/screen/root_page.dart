import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/presentation/screen/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../../external/notification_helper.dart';
import 'login/login_screen.dart';
import 'nav_bottom_main.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    setupFcm();
    context.read<AuthBloc>().add(StartApp());
  }

  Future<void> setupFcm() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
      NotificationHelper().showNotificationFromFCM(remoteMessage);
    });

    FirebaseMessaging.onMessageOpenedApp
        .listen((RemoteMessage remoteMessage) async {
      await Get.to(NavBottomMain(indexPage: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
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
