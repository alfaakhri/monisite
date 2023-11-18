import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatelessWidget {
  static const String id = "splash_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                      tag: 'images/tower.png',
                      child: Image.asset('images/tower.png', scale: 7)),
                  UIHelper.verticalSpaceMedium,
                  Hero(
                    tag: 'toraga-X',
                    child: Text('toraga-X',
                        style:
                            TextStyle(fontSize: 26, color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: Text(
                          "Versi ${snapshot.data?.version ?? ""}",
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorHelpers.colorGreyTextLight,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  }),
            ),
          ],
        ));
  }
}
