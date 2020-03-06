import 'package:flutter/material.dart';
import 'package:flutter_monisite/core/provider/AuthProvider.dart';
import 'package:flutter_monisite/ui/screen/NavBottomMain.dart';
import 'package:flutter_monisite/ui/screen/login/LoginScreen.dart';
import 'package:flutter_monisite/ui/screen/splash/SplashScreen.dart';
import 'package:provider/provider.dart';

class RootPage extends StatelessWidget {
  static const String id = "root_page";
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, AuthProvider auth, _) {
        switch (auth.status) {
          case Status.Uninitialized:
            return SplashScreen();
          case Status.Authenticating:
          case Status.Unauthenticated:
            return LoginScreen();
          case Status.Authenticated:
            return NavBottomMain();
        }
        return SplashScreen();
      },
    );
  }
}
