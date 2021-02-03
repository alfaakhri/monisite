import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_monisite/domain/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_monisite/presentation/screen/root_page.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'domain/bloc/list_report_bloc/list_report_bloc.dart';
import 'domain/bloc/notif_bloc/notif_bloc.dart';
import 'domain/bloc/site_bloc/site_bloc.dart';
import 'domain/provider/auth_provider.dart';
import 'domain/provider/notification_provider.dart';
import 'external/color_helpers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider.instance()),
        ChangeNotifierProvider(
          create: (_) => NotificationProvider(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
          BlocProvider<SiteBloc>(create: (context) => SiteBloc()),
          BlocProvider<NotifBloc>(create: (context) => NotifBloc()),
          BlocProvider<ListReportBloc>(create: (context) => ListReportBloc()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: GoogleFonts.poppins().fontFamily),
          initialRoute: '/root',
          getPages: [GetPage(name: '/root', page: () => RootPage())],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('id', 'ID'),
          ],
        ),
      ),
    );
  }
}
