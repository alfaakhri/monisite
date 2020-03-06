import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  static const String id = "splash_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
        child: Text('Monisite',
            style: GoogleFonts.poppins(fontSize: 26, color: Colors.blueAccent)),
      )),
    );
  }
}
