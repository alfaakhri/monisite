import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/presentation/screen/splash/splash_screen.dart';
import 'package:get/get.dart';

import 'login/login_screen.dart';
import 'nav_bottom_main.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(StartApp());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      cubit: authBloc,
      listener: (context, state) {
        if (state is GetAuthSuccess) {
          Get.offAll(NavBottomMain());
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
