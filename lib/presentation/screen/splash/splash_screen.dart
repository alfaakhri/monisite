import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:flutter_monisite/external/ui_helpers.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  static const String id = "splash_screen";

  @override
  Widget build(BuildContext context) {
    var colorBlueAccent;
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
                    tag: 'Monisite',
                    child: Text('Monisite',
                        style:
                            TextStyle(fontSize: 26, color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Version ' + "1.1.0",

                // 'Version 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: ColorHelpers.colorGreyTextLight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
