import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/presentation/screen/root_page.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import 'domain/bloc/site_bloc/site_bloc.dart';
import 'domain/provider/auth_provider.dart';
import 'domain/provider/history_provider.dart';
import 'domain/provider/monitor_provider.dart';
import 'domain/provider/notification_provider.dart';
import 'domain/provider/site_provider.dart';
import 'external/color_helpers.dart';

void main() => runApp(MyApp());

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
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HistoryProvider(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
          BlocProvider<SiteBloc>(create: (context) => SiteBloc()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: GoogleFonts.poppins().fontFamily
          ),
          initialRoute: '/root',
          getPages: [GetPage(name: '/root', page: () => RootPage())],
        ),
      ),
    );
  }
}
